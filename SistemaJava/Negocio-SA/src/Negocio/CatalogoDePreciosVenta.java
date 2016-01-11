/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Marina
 */
public class CatalogoDePreciosVenta {
     Datos.PrecioVenta preciosDatos =new Datos.PrecioVenta();
    public void altaPrecioVenta(Entidades.PreciosVenta precioVentaNuevo) throws Exception {
     preciosDatos.altaPrecioVenta(precioVentaNuevo);
    }
     public int modificarPrecioVenta(Entidades.PreciosVenta precioVenta) throws Exception {
        return preciosDatos.modificarPrecioVenta(precioVenta);
    }
     public Entidades.PreciosVenta getOnePrecioVenta(int idArticulo, int idTipoCliente) throws Exception {
        return preciosDatos.getOne(idArticulo,idTipoCliente);
    }
      public void restablecerListaPrecios(int idTipoCliente, Date fechaHoy) throws Exception
      {
          preciosDatos.restablecerListaPrecios(idTipoCliente,fechaHoy);
      }
      public void restablecerListaPreciosGenericos(long cuitProveedor, Date fechaHoy) throws Exception
      {
          preciosDatos.restablecerListaPreciosGenericos(cuitProveedor,fechaHoy);
      }
      public ArrayList<Entidades.PreciosVenta> getAllPreciosVVigentes(int idArticulo)
            throws SQLException, ClassNotFoundException, Exception {
        return preciosDatos.getAllPreciosVVigentes(idArticulo);
    }
    
}
