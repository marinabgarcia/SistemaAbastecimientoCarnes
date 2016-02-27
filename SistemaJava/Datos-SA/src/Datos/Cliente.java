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
public class Cliente {

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

    public void altaCliente(Entidades.Cliente cli) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = " insert into cliente (cuitCliente,nombreCliente,apellidoCliente,direccionCliente,telefonoCliente,localidadCliente,provinciaCliente,celularCliente,emailCliente,razonSocialCliente,estadoCliente,dniCliente,idTipoCliente)"
                    + " values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setLong(1, cli.getCuitCliente());
            ps.setString(2, cli.getNombreCliente());
            ps.setString(3, cli.getApellidoCliente());
            ps.setString(4, cli.getDireccionCliente());
            ps.setString(5, cli.getTelefonoCliente());
            ps.setInt(6, cli.getLocalidadCliente());
            ps.setInt(7, cli.getProvinciaCliente());
            ps.setString(8, cli.getCelularCliente());
            ps.setString(9, cli.getEmailCliente());
            ps.setString(10, cli.getRazonSocialCliente());
            ps.setString(11, "Activo");
            ps.setLong(12, cli.getDniCliente());
            ps.setInt(13, cli.getIdTipoCliente());
            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nuevo Cliente. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int eliminarCliente(Long dni) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "UPDATE cliente SET estadoCliente = ? WHERE dniCliente = ?";;
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);

            preparedStmt.setString(1, "Inactivo");
            preparedStmt.setLong(2, dni);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al eliminar cliente. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al eliminar cliente. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int modificarCliente(Entidades.Cliente cli) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update cliente set nombreCliente=?,apellidoCliente=?,direccionCliente=?,telefonoCliente=? ,localidadCliente=?, provinciaCliente=?,celularCliente=?,emailCliente=?,razonSocialCliente=?,cuitCliente=?,idTipoCliente=? where dniCliente=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);

            ps.setString(1, cli.getNombreCliente());
            ps.setString(2, cli.getApellidoCliente());
            ps.setString(3, cli.getDireccionCliente());
            ps.setString(4, cli.getTelefonoCliente());
            ps.setInt(5, cli.getLocalidadCliente());
            ps.setInt(6, cli.getProvinciaCliente());
            ps.setString(7, cli.getCelularCliente());
            ps.setString(8, cli.getEmailCliente());
            ps.setString(9, cli.getRazonSocialCliente());
            ps.setLong(10, cli.getCuitCliente());
            ps.setLong(11, cli.getIdTipoCliente());
            ps.setLong(12, cli.getDniCliente());

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

    public int activarCliente(long dniCliente) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "update cliente set estadoCliente='Activo' where dniCliente=?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, dniCliente);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al activar cliente. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al activar cliente. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Cliente> getClientes(int page, int rg, String sortname, String sortorder, String query, String filtro)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            int limSup = (page - 1) * rg;
            int limInf = rg;
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente order by " + sortname + " " + sortorder + " limit ?,?;";
            } else {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente where " + filtro + " like \"" + query + "%\" order by " + sortname + " " + sortorder + " limit ?,?;";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, limSup);
            ps.setInt(2, limInf);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Cliente> clientes = new ArrayList<Entidades.Cliente>();
            while (rs.next()) {
                Entidades.Cliente cliente = new Entidades.Cliente();
                cliente.setDniCliente(rs.getLong("dniCliente"));
                cliente.setCuitCliente(rs.getLong("cuitCliente"));
                cliente.setRazonSocialCliente(rs.getString("razonSocialCliente"));
                cliente.setEstadoCliente(rs.getString("estadoCliente"));
                cliente.setIdTipoCliente(rs.getInt("idTipoCliente"));
                cliente.setNombreCliente(rs.getString("nombreCliente"));
                cliente.setApellidoCliente(rs.getString("apellidoCliente"));
                cliente.setDireccionCliente(rs.getString("direccionCliente"));
                cliente.setLocalidadCliente(rs.getInt("localidadCliente"));
                cliente.setProvinciaCliente(rs.getInt("provinciaCliente"));
                cliente.setTelefonoCliente(rs.getString("telefonoCliente"));
                cliente.setCelularCliente(rs.getString("celularCliente"));
                cliente.setEmailCliente(rs.getString("emailCliente"));
                cliente.setdProvincia(rs.getString("provincia"));
                cliente.setdLocalidad(rs.getString("localidad"));
                cliente.setdTipoCliente(rs.getString("descripcionTipoCliente"));
                clientes.add(cliente);
            }
            desconectar();
            return clientes;

        } catch (SQLException Ex) {

            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar clientes. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Cliente> getClientesB(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();

            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente where " + "dniCliente like \"" + search + "%\" OR" + " razonSocialCliente like \"" + search + "%\" OR" + " direccionCliente like \"" + search + "%\" OR" + " localidad like \"" + search + "%\" OR" + " cuitCliente like \"" + search + "%\" OR" + " nombreCliente like \"" + search + "%\" OR" + " apellidoCliente like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Cliente> clientes = new ArrayList<Entidades.Cliente>();
            while (rs.next()) {
                Entidades.Cliente cliente = new Entidades.Cliente();
                cliente.setDniCliente(rs.getLong("dniCliente"));
                cliente.setCuitCliente(rs.getLong("cuitCliente"));
                cliente.setRazonSocialCliente(rs.getString("razonSocialCliente"));
                cliente.setEstadoCliente(rs.getString("estadoCliente"));
                cliente.setIdTipoCliente(rs.getInt("idTipoCliente"));
                cliente.setNombreCliente(rs.getString("nombreCliente"));
                cliente.setApellidoCliente(rs.getString("apellidoCliente"));
                cliente.setDireccionCliente(rs.getString("direccionCliente"));
                cliente.setLocalidadCliente(rs.getInt("localidadCliente"));
                cliente.setProvinciaCliente(rs.getInt("provinciaCliente"));
                cliente.setTelefonoCliente(rs.getString("telefonoCliente"));
                cliente.setCelularCliente(rs.getString("celularCliente"));
                cliente.setEmailCliente(rs.getString("emailCliente"));
                cliente.setdProvincia(rs.getString("provincia"));
                cliente.setdLocalidad(rs.getString("localidad"));
                cliente.setdTipoCliente(rs.getString("descripcionTipoCliente"));
                cliente.setCuentaCorrienteCliente(rs.getDouble("cuentaCorrienteCliente"));
                clientes.add(cliente);
            }
            desconectar();
            return clientes;

        } catch (SQLException Ex) {

            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar clientes. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Cliente> getTotalClientes(String query, String filtro) throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente;";
            } else {
                sql = "SELECT * FROM cliente cli inner join provincias pro on pro.idProvincia=cli.provinciaCliente inner join localidades lo on lo.idLocalidad=cli.localidadCliente inner join tipocliente ti on ti.idTipoCliente=cli.idTipoCliente where " + filtro + " like \"" + query + "%\";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Cliente> clientes = new ArrayList<Entidades.Cliente>();
            while (rs.next()) {
                Entidades.Cliente cliente = new Entidades.Cliente();
                cliente.setDniCliente(rs.getLong("dniCliente"));
                cliente.setCuitCliente(rs.getLong("cuitCliente"));
                cliente.setRazonSocialCliente(rs.getString("razonSocialCliente"));
                cliente.setEstadoCliente(rs.getString("estadoCliente"));
                cliente.setIdTipoCliente(rs.getInt("idTipoCliente"));
                cliente.setNombreCliente(rs.getString("nombreCliente"));
                cliente.setApellidoCliente(rs.getString("apellidoCliente"));
                cliente.setDireccionCliente(rs.getString("direccionCliente"));
                cliente.setLocalidadCliente(rs.getInt("localidadCliente"));
                cliente.setProvinciaCliente(rs.getInt("provinciaCliente"));
                cliente.setTelefonoCliente(rs.getString("telefonoCliente"));
                cliente.setCelularCliente(rs.getString("celularCliente"));
                cliente.setEmailCliente(rs.getString("emailCliente"));
                cliente.setdProvincia(rs.getString("provincia"));
                cliente.setdLocalidad(rs.getString("localidad"));
                clientes.add(cliente);
            }
            desconectar();
            return clientes;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar clientes. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public int devolverTipoCliente(long dniCliente) throws SQLException, ClassNotFoundException, Exception {

        conectar();
        // the mysql insert statement
        String query = "select idTipoCliente from cliente where dniCliente=?";
        // create the mysql insert preparedstatement
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        preparedStmt.setLong(1, dniCliente);
        // execute the preparedstatement
        ResultSet resul = preparedStmt.executeQuery();

        if (resul.next()) {

            int tipo = resul.getInt("idTipoCliente");

            return tipo;

        } else {
            return 0;
        }

    }

    public double obtenerCtaCte(long idVenta) throws SQLException, ClassNotFoundException {
        conectar();

        String query = "SELECT cuentaCorrienteCliente FROM cliente INNER JOIN venta WHERE idVenta=?";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        preparedStmt.setLong(1, idVenta);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            Double precio = rs.getDouble("cuentaCorrienteCliente");

            return precio;
        }
        return 0;

    }

    public void actualizoCtaCte(double montoPago, long idVenta) throws SQLException, ClassNotFoundException {
        try {
            conectar();
            String query = "UPDATE cliente cli INNER JOIN venta ven on cli.dniCliente=cli.dniCliente SET cuentaCorrienteCliente=cuentaCorrienteCliente+? where ven.idVenta=?";
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setDouble(1, montoPago);
            preparedStmt.setLong(2, idVenta);
            preparedStmt.executeUpdate();
            desconectar();

        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }
    }
     public int obtenerCantidadClientes() throws SQLException, ClassNotFoundException {
        conectar();

        String query = "SELECT count(dniCliente) FROM cliente";
        PreparedStatement preparedStmt = conexion.prepareStatement(query);
        ResultSet rs = preparedStmt.executeQuery();
        preparedStmt.execute();
        if (rs.next()) {
            int cant = rs.getInt("count(dniCliente)");

            return cant;
        }
        return 0;

    }
     
     public Entidades.Cliente getOne(Long dni)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();

            String sql = "SELECT * FROM cliente cli inner join tipoCliente ti on ti.idTipoCliente=cli.idTipoCliente where dniCliente=?";
 
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, dni);
            ResultSet rs = ps.executeQuery();
            Entidades.Cliente cliente = new Entidades.Cliente();
            while (rs.next()) {
                cliente.setDniCliente(rs.getLong("dniCliente"));
                cliente.setCuitCliente(rs.getLong("cuitCliente"));
                cliente.setRazonSocialCliente(rs.getString("razonSocialCliente"));
                cliente.setEstadoCliente(rs.getString("estadoCliente"));
                cliente.setIdTipoCliente(rs.getInt("idTipoCliente"));
                cliente.setNombreCliente(rs.getString("nombreCliente"));
                cliente.setApellidoCliente(rs.getString("apellidoCliente"));
                cliente.setDireccionCliente(rs.getString("direccionCliente"));
                cliente.setLocalidadCliente(rs.getInt("localidadCliente"));
                cliente.setProvinciaCliente(rs.getInt("provinciaCliente"));
                cliente.setTelefonoCliente(rs.getString("telefonoCliente"));
                cliente.setCelularCliente(rs.getString("celularCliente"));
                cliente.setEmailCliente(rs.getString("emailCliente"));
                cliente.setdTipoCliente(rs.getString("descripcionTipoCliente"));
            }
            desconectar();
            return cliente;

        } catch (SQLException Ex) {

            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar clientes. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

}
