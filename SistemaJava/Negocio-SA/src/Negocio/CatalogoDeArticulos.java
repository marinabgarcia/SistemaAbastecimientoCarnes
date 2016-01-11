/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.Articulo;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Marina
 */
public class CatalogoDeArticulos {
     Datos.Articulo articuloDatos =new Datos.Articulo();
    public void altaDeArticulo(Entidades.Articulo articuloNuevo) throws Exception {
     articuloDatos.altaArticulo(articuloNuevo);
    }
     int modificacionDeArticulo(Entidades.Articulo articuloModificado) throws Exception {
        return articuloDatos.modificarArticulo(articuloModificado);
    }
     int bajaDeArticulo(int id) throws Exception {
       return articuloDatos.eliminarArticulo(id);
    }
    public int activarArticulo(int id) throws Exception {
       return articuloDatos.activarArticulo(id);
    }
    public int recuperarUltimoIdArticulo() throws Exception {
       return articuloDatos.recuperarUltimoIdArticulo();
    }

    public ArrayList<Articulo> getArticulos(int page, int rp, String sortname, String sortorder, String query, String filtro) throws ClassNotFoundException, Exception {
       return articuloDatos.getArticulos(page,rp,sortname,sortorder,query,filtro);
    }

    public ArrayList<Articulo> getTotalArticulos(String query, String filtro) throws ClassNotFoundException, Exception {
        return articuloDatos.getTotalArticulos(query,filtro);
    }
     public ArrayList<Articulo> getArticulosPrecioCompra(String sortname, String sortorder, String searchPhrase, Long cuitProveedor) throws Exception {
        return articuloDatos.getArticulosPrecioCompra(sortname, sortorder, searchPhrase,cuitProveedor);
    }
     public ArrayList<Articulo> getArticulosB(String sortname, String sortorder, String searchPhrase) throws Exception {
        return articuloDatos.getArticulosB(sortname, sortorder, searchPhrase);
    }
     public ArrayList<Articulo> getArticulosPrecioVenta(String sortname, String sortorder, String searchPhrase,int idTipoCliente) throws Exception {
        return articuloDatos.getArticulosPrecioVenta(sortname, sortorder, searchPhrase,idTipoCliente);
    }

    public Entidades.Articulo getOneArticulo(int idArticulo, long cuitProveedor) throws ClassNotFoundException, Exception {
        return articuloDatos.getOne(idArticulo,cuitProveedor);
    }

   public void decrementarStock(int idArticuloRes, int cantidad) throws SQLException, ClassNotFoundException {
        articuloDatos.decrementarStock(idArticuloRes, cantidad);
    }

   public void incrementarStock(int idArticulo, int cantidad ) throws SQLException, ClassNotFoundException {
         articuloDatos.incrementarStock(idArticulo,cantidad);
    }
}
