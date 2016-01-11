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
 * @author Hamal
 */
public class PrecioCompra {

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
            XPath xpath2 = XPathFactory.newInstance().newXPath();
            url = (String) xpath2.compile("//config//jdbc//url").evaluate(document, XPathConstants.STRING);
            driver = (String) xpath2.compile("//config//jdbc//driver").evaluate(document, XPathConstants.STRING);
            username = (String) xpath2.compile("//config//jdbc//username").evaluate(document, XPathConstants.STRING);
            password = (String) xpath2.compile("//config//jdbc//password").evaluate(document, XPathConstants.STRING);
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
    
    public double obtenerPrecio(int idArticulo,Long idProveedor) throws SQLException, ClassNotFoundException, Exception
    { 
        try
        {
            conectar();
            
            String sql = "SELECT * FROM precioscompra where idArticulo=? and cuitProveedor=? and fechaHasta is null";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ps.setLong(2,idProveedor );
            //ps.setDate(3, null);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Entidades.PreciosCompra precio = new Entidades.PreciosCompra();
                
                precio.setMontoPrecioCompra(rs.getDouble("montoPrecioCompra"));
                
                      return precio.getMontoPrecioCompra();
                
                } 
            else {
                throw new Exception("No se encontro el precio por kilo del articulo");
            }

        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public Entidades.PreciosCompra getOne(int idArticulo, long cuitProveedor)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            sql = "SELECT * FROM precioscompra where idArticulo=? and fechaHasta is null and cuitProveedor=?;";

            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ps.setLong(2, cuitProveedor);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Entidades.PreciosCompra precioCompra = new Entidades.PreciosCompra();
                precioCompra.setIdArticulo(rs.getInt("idArticulo"));
                precioCompra.setMontoPrecioCompra(rs.getDouble("montoPrecioCompra"));
                precioCompra.setFechaDesde(rs.getDate("fechaDesde"));
                //precioCompra.setFechaHasta(rs.getDate("fechaHasta"));
                precioCompra.setCuitProveedor(rs.getLong("cuitProveedor"));
                desconectar();
                return precioCompra;
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

    public void altaPrecioCompra(Entidades.PreciosCompra precioNuevoCompra) throws SQLException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query;
            PreparedStatement ps;
            query = "Insert into precioscompra (idArticulo,fechaDesde,cuitProveedor,montoPrecioCompra)"
                    + " values (?,?,?,?)";
            ps = conexion.prepareStatement(query);
            ps.setInt(1, precioNuevoCompra.getIdArticulo());
            ps.setDate(2, precioNuevoCompra.getFechaDesde());
            //ps.setDate(3, precioNuevoCompra.getFechaHasta());
            ps.setLong(3, precioNuevoCompra.getCuitProveedor());
            ps.setDouble(4, precioNuevoCompra.getMontoPrecioCompra());

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

    public int modificarPrecioCompra(Entidades.PreciosCompra precioCompraModificado) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update precioscompra set fechaHasta=?,montoPrecioCompra=? where idArticulo=? and cuitProveedor=? and fechaDesde=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setDate(1, precioCompraModificado.getFechaHasta());
            ps.setDouble(2, precioCompraModificado.getMontoPrecioCompra());
            ps.setInt(3, precioCompraModificado.getIdArticulo());
            ps.setLong(4, precioCompraModificado.getCuitProveedor());
            ps.setDate(5, precioCompraModificado.getFechaDesde());
            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del precio compra. Vuelva a inutentarlo.");
            } else {
                desconectar();
                return resul;
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar datos del precioCompra. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.PreciosCompra> getAllPreciosCVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            sql = "SELECT * FROM precioscompra pre inner join proveedor pro on pro.cuitProveedor=pre.cuitProveedor where idArticulo=? and fechaHasta is null;";

            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, idArticulo);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.PreciosCompra> preciosVigentes = new ArrayList<Entidades.PreciosCompra>();
            while (rs.next()) {
                Entidades.PreciosCompra precioCompra = new Entidades.PreciosCompra();
                precioCompra.setIdArticulo(rs.getInt("idArticulo"));
                precioCompra.setMontoPrecioCompra(rs.getDouble("montoPrecioCompra"));
                //precioCompra.setFechaDesde(rs.getDate("fechaDesde"));
                //precioCompra.setFechaHasta(rs.getDate("fechaHasta"));
                precioCompra.setCuitProveedor(rs.getLong("cuitProveedor"));
                precioCompra.setNombreProveedor(rs.getString("nombreProveedor")+" "+rs.getString("apellidoProveedor"));
                preciosVigentes.add(precioCompra);
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
