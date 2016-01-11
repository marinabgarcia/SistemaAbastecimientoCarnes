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
 * @author Marina
 */
public class CatalogoDeCalidades {
     Datos.Calidad calidadDatos =new Datos.Calidad();
     
     public ArrayList<Entidades.Calidad> getAllCalidades() throws SQLException, ClassNotFoundException, Exception {
        return calidadDatos.getAll();
    }
    
}
