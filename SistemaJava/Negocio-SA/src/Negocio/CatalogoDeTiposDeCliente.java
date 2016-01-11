/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import Entidades.TipoCliente;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Marina
 */
public class CatalogoDeTiposDeCliente {
     Datos.TipoCliente tipoDatos =new Datos.TipoCliente();
     
     public ArrayList<Entidades.TipoCliente> getAllTipos() throws SQLException, ClassNotFoundException, Exception {
        return tipoDatos.getAll();
    }
      public int modificarTipoCliente(Entidades.TipoCliente tipo) throws SQLException, Exception {
        return tipoDatos.modificarTipoCliente(tipo);
    }

   
}
