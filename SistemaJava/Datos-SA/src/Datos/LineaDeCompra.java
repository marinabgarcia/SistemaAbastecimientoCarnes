/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/**
 *
 * @author Hamal
 */
public class LineaDeCompra {

    public Connection conexion;
    //public final static String userDb = "adminjKqSjQm";
    //public final static String passDb = "js7_I7Rw9USI";
    public String url, username, password, driver;

    //Conectar a la Base de datos
    public void conectar() throws SQLException, ClassNotFoundException {
        InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("config.xml");
        Document document;
        try {
            document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(new InputSource(input));
            XPath xpath = XPathFactory.newInstance().newXPath();
            url = (String) xpath.compile("//config//jdbc//url").evaluate(document, XPathConstants.STRING);
            driver = (String) xpath.compile("//config//jdbc//driver").evaluate(document, XPathConstants.STRING);
            username = (String) xpath.compile("//config//jdbc//username").evaluate(document, XPathConstants.STRING);
            password = (String) xpath.compile("//config//jdbc//password").evaluate(document, XPathConstants.STRING);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Proveedor.class.getName()).log(Level.SEVERE, null, ex);
        }
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(url, username, password);
    }

    //Desconectar a la Base de datos
    public void desconectar() throws SQLException, ClassNotFoundException {
        conexion.close();
    }

    public void guardarLineaCompra(ArrayList< Entidades.LineaDeCompra> listaLinea) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            for (int i = 0; i < listaLinea.size(); i++) {

                Entidades.LineaDeCompra listap = new Entidades.LineaDeCompra();
                listap = listaLinea.get(i);
                String query = " insert into lineadecompra (idLineaCompra,cantidadLineaCompra,observacionLineaCompra,precioLineaCompra,pesoLineaCompra,idArticulo,idCompra)" + " values (?,?,?,?,?,?,?)";

                // create the mysql insert preparedstatement
                PreparedStatement preparedStmt = conexion.prepareStatement(query);

                preparedStmt.setLong(1, listap.getIdLineaCompra());
                preparedStmt.setInt(2, listap.getCantidadLineaCompra());
                preparedStmt.setString(3, listap.getObservacionLineaCompra());
                preparedStmt.setDouble(4, listap.getPrecioLineaCompra());
                preparedStmt.setDouble(5, listap.getPesoLineaCompra());
                preparedStmt.setInt(6, listap.getIdArticulo());
                preparedStmt.setLong(7, listap.getIdCompra());

                // execute the preparedstatement
                preparedStmt.execute();
                String query2 = "select stockPeso from articulo where idArticulo=?";
                PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
                preparedStmt2.setInt(1, listap.getIdArticulo());
                ResultSet rs = preparedStmt2.executeQuery();
                preparedStmt2.execute();
                while (rs.next()) {
                    double stock = rs.getDouble("stockPeso");
                    //sumar cantidad de linea de compra no 1
                    double stockNuevo = Math.round((stock + listap.getPesoLineaCompra()) * Math.pow(10, 2)) / Math.pow(10, 2);
                    String query3 = "update articulo set stockPeso=? where idArticulo=?";
                    PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);
                    preparedStmt3.setDouble(1, stockNuevo);
                    preparedStmt3.setInt(2, listap.getIdArticulo());
                    preparedStmt3.execute();

                }

            }
            desconectar();
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nueva línea de pedido. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.LineaDeCompra> getAllLineas(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM lineadecompra li  left join articulo ar on ar.idArticulo=li.idArticulo left join calidad cal on cal.idCalidad=ar.idCalidad where li.idCompra=? order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM lineadecompra li  left join articulo ar on ar.idArticulo=li.idArticulo left join calidad cal on cal.idCalidad=ar.idCalidad where li.idCompra=? and " + "ar.idArticulo like \"" + search + "%\" OR" + " descripcionArticulo like \"" + search + "%\" OR" + " descripcionCalidad like \"" + search + "%\" OR" + " precioLineaCompra like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, idCompra);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.LineaDeCompra> lineas = new ArrayList<Entidades.LineaDeCompra>();
            while (rs.next()) {
                Entidades.LineaDeCompra linea = new Entidades.LineaDeCompra();
                linea.setIdCompra(rs.getLong("idCompra"));
                linea.setIdLineaCompra(rs.getLong("idLineaCompra"));
                linea.setIdLineaCompraS(rs.getString("idLineaCompra"));
                linea.setCantidadLineaCompra(rs.getInt("cantidadLineaCompra"));
                linea.setPesoLineaCompra(rs.getDouble("pesoLineaCompra"));
                linea.setPrecioLineaCompra(rs.getDouble("precioLineaCompra"));
                double precioCompra = Math.round((rs.getDouble("precioLineaCompra") / rs.getDouble("pesoLineaCompra")) * Math.pow(10, 2)) / Math.pow(10, 2);
                linea.setPrecioCompra(precioCompra);
                linea.setObservacionLineaCompra(rs.getString("observacionLineaCompra"));
                linea.setIdArticulo(rs.getInt("idArticulo"));
                linea.setCantidadFraccionada(rs.getInt("cantidadFraccionada"));
                linea.setIdCompra(rs.getLong("idCompra"));
                linea.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                linea.setDescripcionCalidad(rs.getString("descripcionCalidad"));

                lineas.add(linea);
            }
            desconectar();
            return lineas;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void guardarCantidadFraccionada(long idLineaCompra, int cantidadFraccionada) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "UPDATE lineadecompra SET cantidadFraccionada = ? WHERE idLineaCompra = ?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);

            preparedStmt.setInt(1, cantidadFraccionada);
            preparedStmt.setLong(2, idLineaCompra);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al actualizar cantidad fraccionada. Vuelva a intentarlo.");
            } else {
                desconectar();
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al actualizar cantidad fraccionada. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int obtenerUltimaFraccion(long idLineaCompra) throws SQLException, ClassNotFoundException {
        conectar();
        String query2 = "select cantidadFraccionada from lineadecompra where idLineaCompra=?";
        PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
        preparedStmt2.setLong(1, idLineaCompra);
        ResultSet rs = preparedStmt2.executeQuery();
        preparedStmt2.execute();
        while (rs.next()) {
            int ultima = rs.getInt("cantidadFraccionada");
            return ultima;
        }
        return 0;

    }
}
