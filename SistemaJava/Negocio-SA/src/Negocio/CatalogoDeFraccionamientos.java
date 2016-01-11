/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Negocio;

import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Hamal
 */
public class CatalogoDeFraccionamientos {
Datos.Fraccionamiento fraccionamientoDatos=new Datos.Fraccionamiento(); 
   public long crearFraccionamiento(long idLineaCompra, int cantidad) throws SQLException, ClassNotFoundException, Exception {

        long id=fraccionamientoDatos.obtenerUlttimoId();
        long idfraccionamiento= id+1;
        fraccionamientoDatos.crearFraccionamiento(idfraccionamiento,idLineaCompra,cantidad);
        return idfraccionamiento;
    }

    public void guardarFraccionamientos(int idArticulo, long idfraccionamiento,int cantidad) throws Exception {
        
        fraccionamientoDatos.guardarFraccionamientos(idArticulo,idfraccionamiento,cantidad);
    }
     public ArrayList<Entidades.LineaDeCompra> getAllFraccionamientos(String sortname, String sortorder, String search, long idCompra)
            throws SQLException, ClassNotFoundException, Exception {
         return fraccionamientoDatos.getAllFraccionamientos(sortname, sortorder, search, idCompra);
     }

    public void eliminarFraccionamiento(long idFraccionamiento) throws Exception {
        fraccionamientoDatos.eliminarFraccionamiento(idFraccionamiento);
       
    }
    
}
