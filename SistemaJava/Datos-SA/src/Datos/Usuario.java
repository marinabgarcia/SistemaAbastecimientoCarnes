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
public class Usuario {

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

    public Entidades.Usuario validarUsuario(String contraseña, long usuario) throws ClassNotFoundException, Exception {
        try {
            conectar();

            String sql = "SELECT * FROM usuario where dniUsuario=? and contraseña=? and estado=?";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, usuario);
            ps.setString(2, contraseña);
            ps.setString(3, "Activo");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Entidades.Usuario per = new Entidades.Usuario();
                per.setDniUsuario(rs.getInt("dniUsuario"));
                per.setContraseña(rs.getString("contraseña"));
                per.setApellidoUsuario(rs.getString("apellidoUsuario"));
                per.setCelularUsuario(rs.getString("celularUsuario"));
                per.setDireccionUsuario(rs.getString("direccionUsuario"));
                per.setFotoUsuario(rs.getString("fotoUsuario"));
                per.setNombreUsuario(rs.getString("nombreUsuario"));
                per.setTelefonoUsuario(rs.getString("telefonoUsuario"));
                per.setTipoUsuario(rs.getString("tipoUsuario"));
                per.setEstado(rs.getString("estado"));
                per.setProvinciaUsuario(rs.getInt("provinciaUsuario"));
                per.setEmailUsuario(rs.getString("emailUsuario"));
                per.setFechaAlta(rs.getDate("fechaAlta"));
                per.setFechaBaja(rs.getDate("fechaBaja"));
                per.setUltimaSesion(rs.getTime("ultimaSesion"));

                desconectar();
                return per;

            } else {
                throw new Exception("El usuario y/o contraseña son incorrectos.");
            }
        } catch (SQLException Ex) {
            throw Ex;
        } finally {
            desconectar();
        }

    }

    public void altaUsuario(Entidades.Usuario us) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = " insert into usuario (nombreUsuario,apellidoUsuario,direccionUsuario,telefonoUsuario,localidadUsuario,provinciaUsuario,celularUsuario,emailUsuario,fotoUsuario,contraseña,estado,dniUsuario,fechaAlta,tipoUsuario)"
                    + " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setString(1, us.getNombreUsuario());
            ps.setString(2, us.getApellidoUsuario());
            ps.setString(3, us.getDireccionUsuario());
            ps.setString(4, us.getTelefonoUsuario());
            ps.setInt(5, us.getLocalidadUsuario());
            ps.setInt(6, us.getProvinciaUsuario());
            ps.setString(7, us.getCelularUsuario());
            ps.setString(8, us.getEmailUsuario());
            ps.setString(9, us.getFotoUsuario());
            ps.setString(10, us.getContraseña());
            ps.setString(11, "Activo");
            ps.setLong(12, us.getDniUsuario());
            ps.setDate(13, (Date) us.getFechaAlta());
            ps.setString(14, us.getTipoUsuario());
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

    public int modificarCliente(Entidades.Usuario us) throws SQLException, ClassNotFoundException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "";
            if (!"".equals(us.getContraseña())) {
                if (!"".equals(query)) {
                    query = "update usuario set nombreUsuario=?,apellidoUsuario=?,direccionUsuario=?,telefonoUsuario=? ,localidadUsuario=?, provinciaUsuario=?,celularUsuario=?,emailUsuario=?,fotoUsuario=?,contraseña='" + us.getContraseña() + "' where dniUsuario=?";
                } else {
                    query = "update usuario set nombreUsuario=?,apellidoUsuario=?,direccionUsuario=?,telefonoUsuario=? ,localidadUsuario=?, provinciaUsuario=?,celularUsuario=?,emailUsuario=?,fotoUsuario=?,contraseña='" + us.getContraseña() +"' where dniUsuario=?";
                }
            } else {
                if (!"".equals(query)) {
                    query = "update usuario set nombreUsuario=?,apellidoUsuario=?,direccionUsuario=?,telefonoUsuario=? ,localidadUsuario=?, provinciaUsuario=?,celularUsuario=?,emailUsuario=?,fotoUsuario=? where dniUsuario=?";
                } else {
                    query = "update usuario set nombreUsuario=?,apellidoUsuario=?,direccionUsuario=?,telefonoUsuario=? ,localidadUsuario=?, provinciaUsuario=?,celularUsuario=?,emailUsuario=?,fotoUsuario=? where dniUsuario=?";
                }
            }
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);

            ps.setString(1, us.getNombreUsuario());
            ps.setString(2, us.getApellidoUsuario());
            ps.setString(3, us.getDireccionUsuario());
            ps.setString(4, us.getTelefonoUsuario());
            ps.setInt(5, us.getLocalidadUsuario());
            ps.setInt(6, us.getProvinciaUsuario());
            ps.setString(7, us.getCelularUsuario());
            ps.setString(8, us.getEmailUsuario());
            ps.setString(9, us.getFotoUsuario());
            //ps.setString(10, us.getContraseña());
            ps.setLong(10, us.getDniUsuario());

            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del usuario. Vuelva a intentarlo.");
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

    public int eliminarUsuario(Long dni, Date fechaBaja) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "UPDATE usuario SET estado = ?, fechaBaja=? WHERE dniUsuario = ?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);

            preparedStmt.setString(1, "Inactivo");
            preparedStmt.setDate(2, (Date) fechaBaja);
            preparedStmt.setLong(3, dni);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al eliminar usuario. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al eliminar usuario. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public int activarUsuario(Long dni) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "update usuario set estado='Activo', fechaBaja=null where dniUsuario=?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, dni);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al activar usuario. Vuelva a intentarlo.");
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

    public ArrayList<Entidades.Usuario> getTotalUsuarios(String query, String filtro) throws SQLException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=us.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario ";
            } else {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=cli.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario  where " + filtro + " like \"" + query + "%\";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Usuario> usuarios = new ArrayList<Entidades.Usuario>();
            while (rs.next()) {
                Entidades.Usuario usuario = new Entidades.Usuario();
                usuario.setDniUsuario(rs.getLong("dniUsuario"));
                usuario.setNombreUsuario(rs.getString("nombreUsuario"));
                usuario.setApellidoUsuario(rs.getString("apellidoUsuario"));
                usuario.setCelularUsuario(rs.getString("celularUsuario"));
                usuario.setDireccionUsuario(rs.getString("direccionUsuario"));
                usuario.setEmailUsuario(rs.getString("emailUsuario"));
                usuario.setTelefonoUsuario(rs.getString("telefonoUsuario"));
                usuario.setProvinciaUsuario(rs.getInt("provinciaUsuario"));
                usuario.setLocalidadUsuario(rs.getInt("localidadUsuario"));

                usuario.setFotoUsuario(rs.getString("fotoUsuario"));
                usuario.setEstado(rs.getString("estadoUsuario"));
                usuario.setFechaAlta(rs.getDate("fechaAlta"));
                usuario.setFechaBaja(rs.getDate("fechaBaja"));
                usuario.setUltimaSesion(rs.getDate("ultimaSesion"));
                usuarios.add(usuario);
            }
            desconectar();
            return usuarios;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar usuarios. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Usuario> getUsuarios(int page, int rp, String sortname, String sortorder, String query, String filtro) throws SQLException, Exception {
        try {
            conectar();
            int limSup = (page - 1) * rp;
            int limInf = rp;
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=us.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario order by " + sortname + " " + sortorder + " limit ?,?;";
            } else {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=us.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario  where " + filtro + " like \"" + query + "%\" order by " + sortname + " " + sortorder + " limit ?,?;";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, limSup);
            ps.setInt(2, limInf);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Usuario> usuarios = new ArrayList<Entidades.Usuario>();
            while (rs.next()) {
                Entidades.Usuario usuario = new Entidades.Usuario();
                usuario.setDniUsuario(rs.getLong("dniUsuario"));
                usuario.setNombreUsuario(rs.getString("nombreUsuario"));
                usuario.setApellidoUsuario(rs.getString("apellidoUsuario"));
                usuario.setCelularUsuario(rs.getString("celularUsuario"));
                usuario.setDireccionUsuario(rs.getString("direccionUsuario"));
                usuario.setEmailUsuario(rs.getString("emailUsuario"));
                usuario.setTelefonoUsuario(rs.getString("telefonoUsuario"));
                usuario.setProvinciaUsuario(rs.getInt("provinciaUsuario"));
                usuario.setLocalidadUsuario(rs.getInt("localidadUsuario"));
                usuario.setFotoUsuario(rs.getString("fotoUsuario"));
                usuario.setEstado(rs.getString("estadoUsuario"));
                usuario.setFechaAlta(rs.getDate("fechaAlta"));
                usuario.setFechaBaja(rs.getDate("fechaBaja"));
                usuario.setUltimaSesion(rs.getDate("ultimaSesion"));
                usuarios.add(usuario);
            }
            desconectar();
            return usuarios;

        } catch (SQLException Ex) {

            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar clientes. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Usuario> getUsuariosB(String sortname, String sortorder, String search) throws SQLException, Exception {
        try {
            conectar();

            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=us.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM usuario us inner join provincias pro on pro.idProvincia=us.provinciaUsuario inner join localidades lo on lo.idLocalidad=us.localidadUsuario  where " + "dniUsuario like \"" + search + "%\" OR" + " nombreUsuario like \"" + search + "%\" OR" + " apellidoUsuario like \"" + search + "%\" OR" + " localidad like \"" + search + "%\" OR" + " direccionUsuario like \"" + search + "%\" OR" + " provincia like \"" + search + "%\" OR" + " email like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Usuario> usuarios = new ArrayList<Entidades.Usuario>();
            while (rs.next()) {
                Entidades.Usuario usuario = new Entidades.Usuario();
                usuario.setDniUsuario(rs.getLong("dniUsuario"));
                usuario.setNombreUsuario(rs.getString("nombreUsuario"));
                usuario.setApellidoUsuario(rs.getString("apellidoUsuario"));
                usuario.setCelularUsuario(rs.getString("celularUsuario"));
                usuario.setDireccionUsuario(rs.getString("direccionUsuario"));
                usuario.setEmailUsuario(rs.getString("emailUsuario"));
                usuario.setTelefonoUsuario(rs.getString("telefonoUsuario"));
                usuario.setProvinciaUsuario(rs.getInt("provinciaUsuario"));
                usuario.setLocalidadUsuario(rs.getInt("localidadUsuario"));
                usuario.setFotoUsuario(rs.getString("fotoUsuario"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setFechaAltaS(rs.getString("fechaAlta"));
                usuario.setFechaBajaS(rs.getString("fechaBaja"));
                usuario.setUltimaSesion(rs.getDate("ultimaSesion"));
                usuario.setdProvincia(rs.getString("provincia"));
                usuario.setdLocalidad(rs.getString("localidad"));
                usuario.setTipoUsuario(rs.getString("tipoUsuario"));
                usuarios.add(usuario);
            }
            desconectar();
            return usuarios;

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
