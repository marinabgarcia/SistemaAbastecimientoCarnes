/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Hamal
 */
public class CatalogoDeLineasDeCompra {
    Datos.LineaDeCompra ldcDatos= new Datos.LineaDeCompra();
    
    public void nuevaLineaCompra( ArrayList< Entidades.LineaDeCompra> listaLinea) throws ClassNotFoundException, Exception
    {
       
        ldcDatos.guardarLineaCompra(listaLinea);
    }
      public ArrayList<Entidades.LineaDeCompra> getAllLineas(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
          return ldcDatos.getAllLineas( sortname,  sortorder,  search,  idCompra);
      }

    public void guardarCantidadFraccionada(long idLineaCompra, int cantidadFraccionada) throws Exception {
        ldcDatos.guardarCantidadFraccionada(idLineaCompra,cantidadFraccionada);
    }

   public int obtenerUltimaFraccion(long idLineaCompra) throws SQLException, ClassNotFoundException {
       return ldcDatos.obtenerUltimaFraccion(idLineaCompra);
    }
}
