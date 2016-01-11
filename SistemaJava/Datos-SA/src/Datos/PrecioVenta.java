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
 * @author Marina
 */
public class PrecioVenta {

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

    public double obtenerPrecio(int idArticulo, Long idTipoCliente) throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();

            String sql = "SELECT * FROM preciosventa where idArticulo=? and idTipoCliente=? and fechaHasta is null";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ps.setLong(2, idTipoCliente);
            //ps.setDate(3, null);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Entidades.PreciosVenta precio = new Entidades.PreciosVenta();

                precio.setMontoPrecioVenta(rs.getDouble("montoPrecioVenta"));

                return precio.getMontoPrecioVenta();

            } else {
                throw new Exception("No se encontro el precio por kilo del articulo");
            }

        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public Entidades.PreciosVenta getOne(int idArticulo, int idTipoCliente)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            sql = "SELECT * FROM preciosventa where idArticulo=? and fechaHasta is null and idTipoCliente=?;";

            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ps.setInt(2, idTipoCliente);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Entidades.PreciosVenta precioVenta = new Entidades.PreciosVenta();
                precioVenta.setIdArticulo(rs.getInt("idArticulo"));
                precioVenta.setMontoPrecioVenta(rs.getDouble("montoPrecioVenta"));
                precioVenta.setFechaDesde(rs.getDate("fechaDesde"));
                //precioCompra.setFechaHasta(rs.getDate("fechaHasta"));
                precioVenta.setIdTipoCliente(rs.getInt("idTipoCliente"));
                desconectar();
                return precioVenta;
            } else {
                return null;
            }
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void altaPrecioVenta(Entidades.PreciosVenta precioNuevoVenta) throws SQLException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query;
            PreparedStatement ps;
            query = "Insert into preciosventa (idArticulo,fechaDesde,idTipoCliente,montoPrecioVenta)"
                    + " values (?,?,?,?)";
            ps = conexion.prepareStatement(query);
            ps.setInt(1, precioNuevoVenta.getIdArticulo());
            ps.setDate(2, precioNuevoVenta.getFechaDesde());
            //ps.setDate(3, precioNuevoCompra.getFechaHasta());
            ps.setLong(3, precioNuevoVenta.getIdTipoCliente());
            ps.setDouble(4, precioNuevoVenta.getMontoPrecioVenta());

            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nuevo precio. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int modificarPrecioVenta(Entidades.PreciosVenta precioVentaModificado) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update preciosventa set fechaHasta=?,montoPrecioVenta=? where idArticulo=? and idTipoCliente=? and fechaDesde=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setDate(1, precioVentaModificado.getFechaHasta());
            ps.setDouble(2, precioVentaModificado.getMontoPrecioVenta());
            ps.setInt(3, precioVentaModificado.getIdArticulo());
            ps.setLong(4, precioVentaModificado.getIdTipoCliente());
            ps.setDate(5, precioVentaModificado.getFechaDesde());
            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del precio Venta. Vuelva a inutentarlo.");
            } else {
                desconectar();
                return resul;
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar datos del precioVenta. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public void restablecerListaPrecios(int idTipoCliente, Date fechaHoy) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "call cambiarListaPreciosVenta(?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setDate(2, fechaHoy);
            ps.setInt(1, idTipoCliente);

            // execute the preparedstatement
            int resul = ps.executeUpdate();

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar precios de la lista de venta. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public void restablecerListaPreciosGenericos(long cuitProveedor, Date fechaHoy) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "call cambiarListaGenerica(?,?)";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setDate(2, fechaHoy);
            ps.setLong(1, cuitProveedor);

            // execute the preparedstatement
            int resul = ps.executeUpdate();

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar precios de la lista de venta. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.PreciosVenta> getAllPreciosVVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            sql = "SELECT * FROM preciosventa pre inner join tipocliente ti on ti.idTipoCliente=pre.idTipoCliente where idArticulo=? and fechaHasta is null;";

            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.PreciosVenta> preciosVigentes = new ArrayList<Entidades.PreciosVenta>();
            while (rs.next()) {
                Entidades.PreciosVenta precioVenta = new Entidades.PreciosVenta();
                precioVenta.setIdArticulo(rs.getInt("idArticulo"));
                precioVenta.setMontoPrecioVenta(rs.getDouble("montoPrecioVenta"));
                //precioVenta.setFechaDesde(rs.getDate("fechaDesde"));
                //precioCompra.setFechaHasta(rs.getDate("fechaHasta"));
                precioVenta.setIdTipoCliente(rs.getInt("idTipoCliente"));
                precioVenta.setDescripcionTipoCliente(rs.getString("descripcionTipoCliente"));
                preciosVigentes.add(precioVenta);
            }
            desconectar();
            return preciosVigentes;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }
}
