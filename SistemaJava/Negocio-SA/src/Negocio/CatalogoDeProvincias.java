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
public class CatalogoDeProvincias {
    Datos.Provincia provinciaDatos = new Datos.Provincia();
    public ArrayList<Entidades.Provincia> getAll() throws ClassNotFoundException, Exception {
        return provinciaDatos.getAll();
    }
    
}
