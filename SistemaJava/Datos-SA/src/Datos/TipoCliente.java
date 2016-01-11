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
public class TipoCliente {
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

    //Metodo para devolver todos los usuarios
    public ArrayList<Entidades.TipoCliente> getAll() throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql = "SELECT * FROM tipocliente";
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.TipoCliente> tiposCliente = new ArrayList<Entidades.TipoCliente>();

            while (rs.next()) {
                Entidades.TipoCliente tipo = new Entidades.TipoCliente();
                tipo.setIdTipoCliente(rs.getInt("idTipoCliente"));
                tipo.setDescripcionTipoCliente(rs.getString("descripcionTipoCliente"));          
                tipo.setPorcentajeTipoCliente(rs.getDouble("porcentajeTipoCliente"));          
                tiposCliente.add(tipo);
            }
            desconectar();
            return tiposCliente;
        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception E) {
            Exception ExcepcionManejada = new Exception("Error al recuperar todos los Tipos de Cliente. Vuelva a intentarlo", E);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
     public int modificarTipoCliente(Entidades.TipoCliente tipo) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update tipocliente set descripcionTipoCliente=?,porcentajeTipoCliente=? where idTipoCliente=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);  
            ps.setString(1, tipo.getDescripcionTipoCliente());
            ps.setDouble(2, tipo.getPorcentajeTipoCliente());
            ps.setInt(3, tipo.getIdTipoCliente());
  
            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del tipo de cliente. Vuelva a inutentarlo.");
            } else {
                desconectar();
                return resul;
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar datos del tipo de cliente. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }   
    }
}
