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
public class Articulo {
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
    public void altaArticulo(Entidades.Articulo art) throws SQLException, Exception {
        try {
           
            conectar();
            // the mysql insert statement
            String query = " insert into articulo (idArticulo,descripcionArticulo,pesoEstimadoArticulo,estadoArticulo,idCalidad)"
                    + " values (?,?,?,?,?)";
            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);
            ps.setInt(1, art.getIdArticulo());
            ps.setString(2, art.getDescripcionArticulo());
            ps.setDouble(3, art.getPesoEstimadoArticulo());
            ps.setString(4,"Activo" );
            ps.setInt(5,art.getIdCalidad());
            // execute the preparedstatement
            ps.execute();
            desconectar();
        } catch (SQLException ex) {
            throw ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nuevo Articulo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }
     public int eliminarArticulo(int id) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "UPDATE articulo SET estadoArticulo=? WHERE idArticulo=?";;
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setString(1, "Inactivo");
            preparedStmt.setLong(2, id);
            
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al eliminar Artículo. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al eliminar Artículo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
     }  
        public int modificarArticulo(Entidades.Articulo art) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement

            String query = "update articulo set descripcionArticulo=?,pesoEstimadoArticulo=?,idCalidad=? where idArticulo=?";

            // create the mysql insert preparedstatement
            PreparedStatement ps = conexion.prepareStatement(query);                      
            ps.setString(1, art.getDescripcionArticulo());
            ps.setDouble(2, art.getPesoEstimadoArticulo());
            ps.setInt(3, art.getIdCalidad());
            ps.setInt(4, art.getIdArticulo());
            // execute the preparedstatement
            int resul = ps.executeUpdate();
            if (resul == 0) {
                desconectar();
                throw new Exception("Error al modificar datos del artículo. Vuelva a inutentarlo.");
            } else {
                desconectar();
                return resul;
            }

        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al modificar datos del artículo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }   
    }
         public int activarArticulo(int idArticulo) throws SQLException, Exception {
        try {

            conectar();
            // the mysql insert statement
            String query = "update articulo set estadoArticulo='Activo' where idArticulo=?";
            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            preparedStmt.setLong(1, idArticulo);
            // execute the preparedstatement
            int resul = preparedStmt.executeUpdate();
            if (resul == 0) {
                throw new Exception("Error al activar artículo. Vuelva a intentarlo.");
            } else {
                desconectar();
            }
            return resul;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al activar artículo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }
    }

    public ArrayList<Entidades.Articulo> getArticulos(int page, int rg, String sortname, String sortorder, String query, String filtro)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            int limSup = (page - 1) * rg;
            int limInf = rg;
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad order by " + sortname + " " + sortorder + " limit ?,?;";
            } else {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad where " + filtro + " like \"" + query + "%\" order by " + sortname + " " + sortorder + " limit ?,?;";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setInt(1, limSup);
            ps.setInt(2, limInf);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Articulo> articulos = new ArrayList<Entidades.Articulo>();
            while (rs.next()) {
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulo.setDescripcionCalidad(rs.getString("descripcionCalidad"));
                articulo.setIdCalidad(rs.getInt("idCalidad"));
                articulos.add(articulo);
            }
            desconectar();
            return articulos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar artículos. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public ArrayList<Entidades.Articulo> getTotalArticulos(String query, String filtro) throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            String sql;
            if ("".equals(query)) {
                sql = "SELECT * FROM articulo;";
            } else {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad where " + filtro + " like \"" + query + "%\";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Articulo> articulos = new ArrayList<Entidades.Articulo>();
            while (rs.next()) {
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulos.add(articulo);
            }
            desconectar();
            return articulos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar articulo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
    public int recuperarUltimoIdArticulo() throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();
            // the mysql insert statement
            String query = " select max(idArticulo) from articulo";

            // create the mysql insert preparedstatement
            PreparedStatement preparedStmt = conexion.prepareStatement(query);
            // execute the preparedstatement
            ResultSet rs = preparedStmt.executeQuery();
            int ultimoId = 0;
            while (rs.next()) {
                ultimoId = (rs.getInt("max(idArticulo)"));
            }
            desconectar();
            return ultimoId;
        } catch (SQLException exc) {
            throw exc;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al agregar nuevo articulo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
        public ArrayList<Entidades.Articulo> getArticulosPrecioCompra(String sortname, String sortorder, String search,Long cuitProveedor)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();  
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad left join (select * from precioscompra pre where fechaHasta is null and cuitProveedor=? or cuitProveedor is null) pre on ar.idArticulo=pre.idArticulo order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad left join (select * from precioscompra pre where fechaHasta is null and cuitProveedor=? or cuitProveedor is null) pre on ar.idArticulo=pre.idArticulo where " + "ar.idArticulo like \"" + search + "%\" OR" + " descripcionArticulo like \"" + search + "%\" OR" + " descripcionCalidad like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, cuitProveedor);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Articulo> articulos = new ArrayList<Entidades.Articulo>();
            while (rs.next()) {
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulo.setDescripcionCalidad(rs.getString("descripcionCalidad"));
                articulo.setIdCalidad(rs.getInt("idCalidad"));
                articulo.setMontoPrecioCompra(rs.getDouble("montoPrecioCompra"));
                articulos.add(articulo);
            }
            desconectar();
            return articulos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar artículos. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
        public ArrayList<Entidades.Articulo> getArticulosPrecioVenta(String sortname, String sortorder, String search,int idTipoCliente)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();  
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad left join (select * from preciosventa pre where fechaHasta is null and idTipoCliente=? or idTipoCliente is null) pre on ar.idArticulo=pre.idArticulo order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad left join (select * from preciosventa pre where fechaHasta is null and idTipoCliente=? or idTipoCliente is null) pre on ar.idArticulo=pre.idArticulo where " + "ar.idArticulo like \"" + search + "%\" OR" + " descripcionArticulo like \"" + search + "%\" OR" + " descripcionCalidad like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(1, idTipoCliente);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Articulo> articulos = new ArrayList<Entidades.Articulo>();
            while (rs.next()) {
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulo.setDescripcionCalidad(rs.getString("descripcionCalidad"));
                articulo.setIdCalidad(rs.getInt("idCalidad"));
                articulo.setMontoPrecioCompra(rs.getDouble("montoPrecioVenta"));
                articulo.setStockUnidad(rs.getInt("stockUnidad"));
                articulos.add(articulo);
            }
            desconectar();
            return articulos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar artículos. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
         public Entidades.Articulo getOne(int idArticulo,Long cuitProveedor)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();  
            String sql;
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad inner join precioscompra pre on ar.idArticulo=pre.idArticulo where ar.idArticulo=? and fechaHasta is null and cuitProveedor=?";
            
            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setLong(2, cuitProveedor);
            ps.setInt(1, idArticulo);
            ResultSet rs = ps.executeQuery();
            Entidades.Articulo articulo = new Entidades.Articulo();
            if (rs.next()) {               
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulo.setDescripcionCalidad(rs.getString("descripcionCalidad"));
                articulo.setIdCalidad(rs.getInt("idCalidad"));
                articulo.setMontoPrecioCompra(rs.getDouble("montoPrecioCompra"));
   
            }
            desconectar();
            return articulo;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar artículo. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }

    public void decrementarStock(int idArticuloRes, int cantidad) throws SQLException, ClassNotFoundException {
        conectar();
                String query2="select stockUnidad from articulo where idArticulo=?";
                    PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
                    preparedStmt2.setInt(1, idArticuloRes);
                    ResultSet rs =preparedStmt2.executeQuery();
                    preparedStmt2.execute();
                    while(rs.next())
                    {
                    int stock=rs.getInt("stockUnidad");
                    int stockNuevo=stock-cantidad;
            String query3="update articulo set stockUnidad=? where idArticulo=?";
            PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);
            preparedStmt3.setInt(1, stockNuevo);
            preparedStmt3.setInt(2, idArticuloRes );
            preparedStmt3.execute();
            
                    }
    }

    public void incrementarStock(int idArticulo, int cantidad) throws SQLException, ClassNotFoundException {
         conectar();
                String query2="select stockUnidad from articulo where idArticulo=?";
                    PreparedStatement preparedStmt2 = conexion.prepareStatement(query2);
                    preparedStmt2.setInt(1, idArticulo);
                    ResultSet rs =preparedStmt2.executeQuery();
                    preparedStmt2.execute();
                    while(rs.next())
                    {
                    int stock=rs.getInt("stockUnidad");
                    int stockNuevo=stock+cantidad;
            String query3="update articulo set stockUnidad=? where idArticulo=?";
            PreparedStatement preparedStmt3 = conexion.prepareStatement(query3);
            preparedStmt3.setInt(1, stockNuevo);
            preparedStmt3.setInt(2, idArticulo );
            preparedStmt3.execute();
            
                    }
    }
   
        public ArrayList<Entidades.Articulo> getArticulosB(String sortname, String sortorder, String search)
            throws SQLException, ClassNotFoundException, Exception {
        try {
            conectar();  
            String sql;
            if ("".equals(search)) {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad order by " + sortname + " " + sortorder + ";";
            } else {
                sql = "SELECT * FROM articulo ar inner join calidad cal on ar.idCalidad=cal.idCalidad where " + "ar.idArticulo like \"" + search + "%\" OR" + " descripcionArticulo like \"" + search + "%\" OR" + " descripcionCalidad like \"" + search + "%\" order by " + sortname + " " + sortorder + ";";
            }
            PreparedStatement ps = conexion.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Entidades.Articulo> articulos = new ArrayList<Entidades.Articulo>();
            while (rs.next()) {
                Entidades.Articulo articulo = new Entidades.Articulo();
                articulo.setIdArticulo(rs.getInt("idArticulo"));
                articulo.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                articulo.setPesoEstimadoArticulo(rs.getDouble("pesoEstimadoArticulo"));
                articulo.setEstadoArticulo(rs.getString("estadoArticulo"));
                articulo.setDescripcionCalidad(rs.getString("descripcionCalidad"));
                articulo.setIdCalidad(rs.getInt("idCalidad"));
                articulo.setStockUnidad(rs.getInt("stockUnidad"));
                articulos.add(articulo);
            }
            desconectar();
            return articulos;

        } catch (SQLException Ex) {
            throw Ex;
        } catch (Exception Ex) {
            Exception ExcepcionManejada = new Exception("Error al recuperar artículos. Vuelva a intentarlo.", Ex);
            throw ExcepcionManejada;
        } finally {
            desconectar();
        }

    }
}
