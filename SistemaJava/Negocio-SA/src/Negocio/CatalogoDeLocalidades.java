/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Negocio;

import java.util.ArrayList;

/**
 *
 * @author Marina
 */
public class CatalogoDeLocalidades {
     Datos.Localidad localidadDatos = new Datos.Localidad();
    public ArrayList<Entidades.Localidad> getAll(int idProvincia) throws ClassNotFoundException, Exception {
        return localidadDatos.getAll(idProvincia);
    }
    
}
