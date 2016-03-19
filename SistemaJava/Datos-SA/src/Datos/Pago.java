/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Datos;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
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
public class Pago {

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

    public void guardarPago(Entidades.Pago pago) throws SQLException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query = " insert into pago (idTransaccion,tipoTransaccion,formaDePago,montoPago,fechaPago,horaPago,nroCheque, nombreCheque,bancoCheque,dniUsuario)" + " values (?,?,?,?,?,?,?,?,?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, pago.getIdTransaccion());
            preparedStmt.setString(2, pago.getTipoTransaccion());

            preparedStmt.setString(3, pago.getFormaDePago());
            preparedStmt.setDouble(4, pago.getMontoPago());
            java.sql.Date sqlDate2;
            java.util.Date javaDate1 = pago.getFechaPago();
            sqlDate2 = new java.sql.Date(javaDate1.getTime());
            preparedStmt.setDate(5, sqlDate2);
            preparedStmt.setTime(6, pago.getHoraPago());
            preparedStmt.setString(7, pago.getNroCheque());
            preparedStmt.setString(8, pago.getNombreCheque());
            preparedStmt.setString(9, pago.getBancoCheque());
            preparedStmt.setLong(10, pago.getDniUsuario());

            // execute the preparedstatement
            preparedStmt.execute();

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar pago. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Pago> getAllPagos(String sortname, String sortorder, String search, long idTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM pago where idTransaccion=? order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM pago where idTransaccion=? and " + "idTransaccion like \"" + search + "%\" OR" + " formaDePago like \"" + search + "%\" OR" + " nroCheque like \"" + search + "%\" OR" + " nombreCheque like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, idTransaccion);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Pago> pagos = new ArrayList<Entidades.Pago>();
            while (rs.next()) {
                Entidades.Pago pago = new Entidades.Pago();
                pago.setIdCP(rs.getString("idTransaccion")+rs.getString("fechaPago")+rs.getString("horaPago"));
                pago.setIdTransaccion(rs.getLong("idTransaccion"));
                pago.setIdTransaccionS(rs.getString("idTransaccion"));
                pago.setTipoTransaccion(rs.getString("tipoTransaccion"));
                pago.setFormaDePago(rs.getString("formaDePago"));
                pago.setMontoPago(rs.getDouble("montoPago"));
                pago.setFechaPagoS(rs.getString("fechaPago"));
                pago.setHoraPagoS(rs.getString("horaPago"));
                pago.setNroCheque(rs.getString("nroCheque"));
                pago.setNombreCheque(rs.getString("nombreCheque"));
                pago.setBancoCheque(rs.getString("bancoCheque"));

                pagos.add(pago);
            }
            desconectar();
            return pagos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Pago> getAllPagosTipo(String sortname, String sortorder, String search, String tipoTransaccion)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql = "";
            if ("compra".equals(tipoTransaccion)) {
                if ("".equals(search)) {
                    sql = "SELECT * FROM pago pa inner join compra com on com.idCompra=pa.idTransaccion inner join proveedor pro on pro.cuitProveedor=com.cuitProveedor where tipoTransaccion=? order by " + sortname + " " + sortorder + ";";
                } else {
                    sql = "SELECT * FROM pago pa inner join compra com on com.idCompra=pa.idTransaccion inner join proveedor pro on pro.cuitProveedor=com.cuitProveedor where tipoTransaccion=? and " + "idTransaccion like \"" + search + "%\" OR" + " formaDePago like \"" + search + "%\" OR" + " bancoCheque like \"" + search  + "%\" OR"+" fechaPago like \"" + search + "%\" OR" + " pro.cuitProveedor like \"" + search + "%\" OR" + " nombreProveedor like \"" + search + "%\" OR" + " apellidoProveedor like \"" + search + "%\" OR" + " idCompra like \"" + search + "%\" OR" + " nroCheque like \"" + search + "%\" OR" + " nombreCheque like \"" + search + "%\" OR" + " montoPago like \""  + search+ "%\" order by " + sortname + " " + sortorder + ";";
                }
            }
            if ("venta".equals(tipoTransaccion)) {
                if ("".equals(search)) {
                    sql = "SELECT * FROM pago pa inner join venta ven on ven.idVenta=pa.idTransaccion inner join cliente cli on cli.dniCliente=ven.dniCliente where tipoTransaccion=? order by " + sortname + " " + sortorder + ";";
                } else {
                    sql = "SELECT * FROM pago pa inner join venta ven on ven.idVenta=pa.idTransaccion inner join cliente cli on cli.dniCliente=ven.dniCliente where tipoTransaccion=? and " + "idTransaccion like \"" + search + "%\" OR" + " formaDePago like \"" + search + "%\" OR" + " bancoCheque like \"" + search + "%\" OR" + " cli.dniCliente like \"" + search + "%\" OR" + " nombreCliente like \"" + search + "%\" OR" + " apellidoCliente like \"" + search + "%\" OR" + " idVenta like \"" + search + "%\" OR" + " razonSocialCliente like \"" + search + "%\" OR" + " cuitCliente like \"" + search + "%\" OR" + " nroCheque like \"" + search + "%\" OR" +" fechaPago like \"" + search + "%\" OR" +" montoPago like \"" + search + "%\" OR" + " nombreCheque like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
                }
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, tipoTransaccion);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Pago> pagos = new ArrayList<Entidades.Pago>();
            while (rs.next()) {
                Entidades.Pago pago = new Entidades.Pago();
                pago.setIdTransaccion(rs.getLong("idTransaccion"));
                pago.setIdTransaccionS(rs.getString("idTransaccion"));
                pago.setTipoTransaccion(rs.getString("tipoTransaccion"));
                pago.setFormaDePago(rs.getString("formaDePago"));
                pago.setMontoPago(rs.getDouble("montoPago"));
                pago.setFechaPagoS(rs.getString("fechaPago"));
                pago.setHoraPagoS(rs.getString("horaPago"));
                pago.setNroCheque(rs.getString("nroCheque"));
                pago.setNombreCheque(rs.getString("nombreCheque"));
                pago.setBancoCheque(rs.getString("bancoCheque"));
                if ("compra".equals(tipoTransaccion)) {
                    pago.setNombre(rs.getString("nombreProveedor") + " " + rs.getString("apellidoProveedor"));
                    pago.setCuit(rs.getString("cuitProveedor"));
                    pago.setId(rs.getString("idCompra"));
                    pago.setTelefono(rs.getString("telefonoProveedor"));
                    pago.setCelular(rs.getString("celularProveedor"));
                }
                if ("venta".equals(tipoTransaccion)) {
                    pago.setNombre(rs.getString("nombreCliente") + " " + rs.getString("apellidoCliente"));
                    pago.setCuit(rs.getString("cuitCliente"));
                    pago.setDni(rs.getString("dniCliente"));
                    pago.setRazonSocial(rs.getString("razonSocialCliente"));
                    pago.setId(rs.getString("idVenta"));
                    pago.setTelefono(rs.getString("telefonoCliente"));
                    pago.setCelular(rs.getString("celularCliente"));
                }
                pagos.add(pago);
            }
            desconectar();
            return pagos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void eliminarPago(long idPago,Date fechaPago,Time horaPago) throws SQLException, Exception {
                try {

            conectar();
            // the mysql insert statement

            String query = "DELETE FROM pago WHERE idTransaccion=? and fechaPago=? and horaPago=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, idPago);
            ps.setDate(2, fechaPago);
            ps.setTime(3, horaPago);

            // execute the preparedstatement
            int i =ps.executeUpdate();
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
       
    }
}
