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
 * @author Marina
 */
public class Proveedor {

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

    public void altaProveedor(Entidades.Proveedor pro) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = " insert into proveedor (cuitProveedor,nombreProveedor,apellidoProveedor,direccionProveedor,telefonoProveedor,localidadProveedor,provinciaProveedor,celularProveedor,emailProveedor,cuentaCorrienteProveedor,estadoProveedor)"
                    + " values (?,?,?,?,?,?,?,?,?,?,?)";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, pro.getCuitProveedor());
            ps.setString(2, pro.getNombreProveedor());
            ps.setString(3, pro.getApellidoProveedor());
            ps.setString(4, pro.getDireccionProveedor());
            ps.setString(5, pro.getTelefonoProveedor());
            ps.setInt(6, pro.getLocalidadProveedor());
            ps.setInt(7, pro.getProvinciaProveedor());
            ps.setString(8, pro.getCelularProveedor());
            ps.setString(9, pro.getEmailProveedor());
            ps.setDouble(10, pro.getCuentaCorrienteProveedor());
            ps.setString(11, "Activo");
            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nuevo Proveedor. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int eliminarProveedor(Long cuit) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "UPDATE proveedor SET estadoProveedor=? WHERE cuitProveedor=?";;
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setString(1, "Inactivo");
            preparedStmt.setLong(2, cuit);

            // execute the preparedstatementee
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al eliminar proveedor. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al eliminar proveedor. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int modificarProveedor(Entidades.Proveedor pro) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update proveedor set nombreProveedor=?,apellidoProveedor=?,direccionProveedor=?,telefonoProveedor=? ,localidadProveedor=?, provinciaProveedor=?,celularProveedor=?,emailProveedor=?,cuentaCorrienteProveedor=? where cuitProveedor=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);

            ps.setString(1, pro.getNombreProveedor());
            ps.setString(2, pro.getApellidoProveedor());
            ps.setString(3, pro.getDireccionProveedor());
            ps.setString(4, pro.getTelefonoProveedor());
            ps.setInt(5, pro.getLocalidadProveedor());
            ps.setInt(6, pro.getProvinciaProveedor());
            ps.setString(7, pro.getCelularProveedor());
            ps.setString(8, pro.getEmailProveedor());
            ps.setDouble(9, pro.getCuentaCorrienteProveedor());
            ps.setLong(10, pro.getCuitProveedor());
            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del proveedor. Vuelva a intentarlo.");
            } else {
                desconectar();
                return resul;
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar datos del proveedor. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public int activarProveedor(long cuitProveedor) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "update proveedor set estadoProveedor='Activo' where cuitProveedor=?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, cuitProveedor);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al activar Proveedor. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al activar Proveedor. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Proveedor> getProveedores(int page, int rg, String sortname, String sortorder, String query, String filtro)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            int limSup = (page - 1) * rg;
            int limInf = rg;
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM proveedor cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor order by " + sortname + " " + sortorder + " limit ?,?;";
            } else {
                sql = "SELECT * FROM proveedor cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor where " + filtro + " like \"" + query + "%\" order by " + sortname + " " + sortorder + " limit ?,?;";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, limSup);
            ps.setInt(2, limInf);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Proveedor> proovedores = new ArrayList<Entidades.Proveedor>();
            while (rs.next()) {
                Entidades.Proveedor proveedor = new Entidades.Proveedor();
                proveedor.setCuitProveedor(rs.getLong("cuitProveedor"));
                proveedor.setEstadoProveedor(rs.getString("estadoProveedor"));
                proveedor.setNombreProveedor(rs.getString("nombreProveedor"));
                proveedor.setApellidoProveedor(rs.getString("apellidoProveedor"));
                proveedor.setDireccionProveedor(rs.getString("direccionProveedor"));
                proveedor.setLocalidadProveedor(rs.getInt("localidadProveedor"));
                proveedor.setProvinciaProveedor(rs.getInt("provinciaProveedor"));
                proveedor.setTelefonoProveedor(rs.getString("telefonoProveedor"));
                proveedor.setCelularProveedor(rs.getString("celularProveedor"));
                proveedor.setEmailProveedor(rs.getString("emailProveedor"));
                proveedor.setdProvincia(rs.getString("provincia"));
                proveedor.setdLocalidad(rs.getString("localidad"));
                proovedores.add(proveedor);
            }
            desconectar();
            return proovedores;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar proveedores. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Proveedor> getTotalProveedores(String query, String filtro) throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM proveedor cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor;";
            } else {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor where " + filtro + " like \"" + query + "%\";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Proveedor> proovedores = new ArrayList<Entidades.Proveedor>();
            while (rs.next()) {
                Entidades.Proveedor proveedor = new Entidades.Proveedor();
                proveedor.setCuitProveedor(rs.getLong("cuitProveedor"));
                proveedor.setEstadoProveedor(rs.getString("estadoProveedor"));
                proveedor.setNombreProveedor(rs.getString("nombreProveedor"));
                proveedor.setApellidoProveedor(rs.getString("apellidoProveedor"));
                proveedor.setDireccionProveedor(rs.getString("direccionProveedor"));
                proveedor.setLocalidadProveedor(rs.getInt("localidadProveedor"));
                proveedor.setProvinciaProveedor(rs.getInt("provinciaProveedor"));
                proveedor.setTelefonoProveedor(rs.getString("telefonoProveedor"));
                proveedor.setCelularProveedor(rs.getString("celularProveedor"));
                proveedor.setEmailProveedor(rs.getString("emailProveedor"));
                proveedor.setdProvincia(rs.getString("provincia"));
                proveedor.setdLocalidad(rs.getString("localidad"));
                proovedores.add(proveedor);
            }
            desconectar();
            return proovedores;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar Proveedores. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Proveedor> getAllProveedores()
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            sql = "SELECT * FROM proveedor;";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Proveedor> proovedores = new ArrayList<Entidades.Proveedor>();
            while (rs.next()) {
                Entidades.Proveedor proveedor = new Entidades.Proveedor();
                proveedor.setCuitProveedor(rs.getLong("cuitProveedor"));
                proveedor.setEstadoProveedor(rs.getString("estadoProveedor"));
                proveedor.setNombreProveedor(rs.getString("nombreProveedor"));
                proveedor.setApellidoProveedor(rs.getString("apellidoProveedor"));
                proveedor.setDireccionProveedor(rs.getString("direccionProveedor"));
                proveedor.setLocalidadProveedor(rs.getInt("localidadProveedor"));
                proveedor.setProvinciaProveedor(rs.getInt("provinciaProveedor"));
                proveedor.setTelefonoProveedor(rs.getString("telefonoProveedor"));
                proveedor.setCelularProveedor(rs.getString("celularProveedor"));
                proveedor.setEmailProveedor(rs.getString("emailProveedor"));
                proovedores.add(proveedor);
            }
            desconectar();
            return proovedores;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar proveedores. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public double obtenerCtaCte(long idCompra) throws SQLException, ClassNotFoundException {
        conectar();
        String query = "SELECT cuentaCorrienteProveedor FROM proveedor INNER JOIN compra WHERE idCompra=?";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        preparedStmt.setLong(1, idCompra);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            Double precio = rs.getDouble("cuentaCorrienteProveedor");
            return precio;
        }
        return 0;

    }

    public void actualizoCtaCte(double montoPago, long idCompra) throws SQLException, ClassNotFoundException {
        try {
            conectar();
            String query = "UPDATE proveedor pro INNER JOIN compra com on com.cuitProveedor=pro.cuitProveedor SET cuentaCorrienteProveedor=cuentaCorrienteProveedor+? where com.idCompra=?";
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setDouble(1, montoPago);
            preparedStmt.setLong(2, idCompra);
            preparedStmt.executeUpdate();
            desconectar();
        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
    }
     public ArrayList<Entidades.Proveedor> getProveedoresB(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM proveedor cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM proveedor cli inner join provincias pro on pro.idProvincia=cli.provinciaProveedor inner join localidades lo on lo.idLocalidad=cli.localidadProveedor where " + "cuitProveedor like \"" + search + "%\" OR" + " nombreProveedor like \"" + search + "%\" OR" + " direccionProveedor like \"" + search + "%\" OR" + " localidad like \"" + search + "%\" OR" + " apellidoProveedor like \"" + search + "%\" OR" + " provincia like \"" + search + "%\" OR" + " telefonoProveedor like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Proveedor> proovedores = new ArrayList<Entidades.Proveedor>();
            while (rs.next()) {
                Entidades.Proveedor proveedor = new Entidades.Proveedor();
                proveedor.setCuitProveedor(rs.getLong("cuitProveedor"));
                proveedor.setEstadoProveedor(rs.getString("estadoProveedor"));
                proveedor.setNombreProveedor(rs.getString("nombreProveedor"));
                proveedor.setApellidoProveedor(rs.getString("apellidoProveedor"));
                proveedor.setDireccionProveedor(rs.getString("direccionProveedor"));
                proveedor.setLocalidadProveedor(rs.getInt("localidadProveedor"));
                proveedor.setProvinciaProveedor(rs.getInt("provinciaProveedor"));
                proveedor.setTelefonoProveedor(rs.getString("telefonoProveedor"));
                proveedor.setCelularProveedor(rs.getString("celularProveedor"));
                proveedor.setEmailProveedor(rs.getString("emailProveedor"));
                proveedor.setdProvincia(rs.getString("provincia"));
                proveedor.setdLocalidad(rs.getString("localidad"));
                proveedor.setCuentaCorrienteProveedor(rs.getDouble("cuentaCorrienteProveedor"));
                proovedores.add(proveedor);
            }
            desconectar();
            return proovedores;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar proveedores. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
     public int obtenerCantidadProveedores() throws SQLException, ClassNotFoundException {
        conectar();

        String query = "SELECT count(cuitProveedor) FROM proveedor";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            int cant = rs.getInt("count(cuitProveedor)");

            return cant;
        }
        return 0;

    }


}
