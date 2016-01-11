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
import java.sql.Statement;
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
public class Fraccionamiento {

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
            Logger.getLogger(Calidad.class.getName()).log(Level.SEVERE, null, ex);
        } catch (XPathExpressionException ex) {
            Logger.getLogger(Calidad.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Calidad.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Calidad.class.getName()).log(Level.SEVERE, null, ex);
        }
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(url, username, password);
    }

    //Desconectar a la Base de datos
    public void desconectar() throws SQLException, ClassNotFoundException {
        conexion.close();
    }

    public long obtenerUlttimoId() throws SQLException, ClassNotFoundException {
        conectar();
        long c = 0;
        // String sql="SELECT count(*) from propiedad";
        String sql = "SELECT MAX(ifnull(idFraccionamiento,0)) AS idFraccionamiento FROM fraccionamiento";
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery(sql);
        if (rs.next()) {
            c = rs.getLong(1);
        }

        return c;
    }

    public void crearFraccionamiento(long idfraccionamiento, long idLineaCompra, int cantidad) throws SQLException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query = " insert into fraccionamiento (idLineaDeCompra,idFraccionamiento,cantidadFraccionamiento)"
                    + " values (?,?,?)";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, idLineaCompra);
            ps.setLong(2, idfraccionamiento);
            ps.setInt(3, cantidad);
            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar Fraccionamiento. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
    public void borrarFraccionamiento(long idfraccionamiento) throws SQLException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query = "delete from fraccionamiento where idFraccionamiento=?; delete from articulofraccionamiento where idFraccionamiento=?;";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, idfraccionamiento);
            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al borrar Fraccionamiento. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public void guardarFraccionamientos(int idArticulo, long idfraccionamiento,int cantidad) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = " insert into articulofraccionamiento (idArticulo,idFraccionamiento,cantidad)" + " values (?,?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);

            ps.setLong(1, idArticulo);
            ps.setLong(2, idfraccionamiento);
            ps.setLong(3, cantidad);

            // execute the preparedstatement
            ps.execute();
            desconectar();

        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar Fraccionamiento. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
    public ArrayList<Entidades.LineaDeCompra> getAllFraccionamientos(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM lineadecompra li inner join fraccionamiento fra on fra.idLineaDeCompra=li.idLineaCompra inner join articulofraccionamiento arfra on arfra.idFraccionamiento=fra.idFraccionamiento inner join articulo ar on ar.idArticulo=arfra.idArticulo left join calidad cal on cal.idCalidad=ar.idCalidad where li.idCompra=? order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM lineadecompra li inner join fraccionamiento fra on fra.idLineaDeCompra=li.idLineaCompra inner join articulofraccionamiento arfra on arfra.idFraccionamiento=fra.idFraccionamiento inner join articulo ar on ar.idArticulo=arfra.idArticulo left join calidad cal on cal.idCalidad=ar.idCalidad where li.idCompra=? and " + "ar.idArticulo like \"" + search + "%\" OR" + " descripcionArticulo like \"" + search + "%\" OR" + " descripcionCalidad like \"" + search + "%\" OR" + " precioLineaCompra like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, idCompra);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.LineaDeCompra> lineas = new ArrayList<Entidades.LineaDeCompra>();
            while (rs.next()) {
                Entidades.LineaDeCompra linea = new Entidades.LineaDeCompra();
                linea.setIdCompra(rs.getLong("idCompra"));
                linea.setIdLineaCompra(rs.getLong("idLineaCompra"));
                linea.setCantidadLineaCompra(rs.getInt("cantidad"));
                linea.setIdFraccionamiento(rs.getInt("idFraccionamiento"));
                //linea.setPesoLineaCompra(rs.getDouble("pesoLineaCompra"));
                //linea.setPrecioLineaCompra(rs.getDouble("precioLineaCompra"));
                //double precioCompra = Math.round((rs.getDouble("precioLineaCompra") / rs.getDouble("pesoLineaCompra")) * Math.pow(10, 2)) / Math.pow(10, 2);
                //linea.setPrecioCompra(precioCompra);
                //linea.setObservacionLineaCompra(rs.getString("observacionLineaCompra"));
                linea.setIdArticulo(rs.getInt("arfra.idArticulo"));
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
    public void eliminarFraccionamiento(long idFraccionamiento) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "delete from fraccionamiento where idFraccionamiento=?;";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, idFraccionamiento);
           
            
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            String query2 = "delete from articulofraccionamiento where idFraccionamiento=?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
            preparedStmt2.setLong(1, idFraccionamiento);
            int resul2=preparedStmt2.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al eliminar Fraccionamiento. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
           // return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al eliminar Artículo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }





}
