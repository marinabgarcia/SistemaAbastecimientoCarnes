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
public class CatalogoDeLineasDeVenta {
     Datos.LineaDeVenta ldvDatos= new Datos.LineaDeVenta();
    
    public void nuevaLineaVenta( ArrayList< Entidades.LineaDeVenta> listaLinea) throws ClassNotFoundException, Exception
    {
       
        ldvDatos.guardarLineaVenta(listaLinea);
    }
    public ArrayList<Entidades.LineaDeVenta> getAllLineas(String sortname, String sortorder, String search, long idVenta)
            throws SQLException, ClassNotFoundException, Exception {
          return ldvDatos.getAllLineas( sortname,  sortorder,  search,  idVenta);
      }
    
}
