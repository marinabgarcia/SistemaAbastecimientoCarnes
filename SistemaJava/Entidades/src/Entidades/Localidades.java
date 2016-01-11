/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

/**
 *
 * @author Hamal
 */
public class Localidades {
    private int idLocalidad;
    private int idProvincia;
    private String descripcionLocalidad;

    /**
     * @return the idLocalidad
     */
    public int getIdLocalidad() {
        return idLocalidad;
    }

    /**
     * @param idLocalidad the idLocalidad to set
     */
    public void setIdLocalidad(int idLocalidad) {
        this.idLocalidad = idLocalidad;
    }

    /**
     * @return the idProvincia
     */
    public int getIdProvincia() {
        return idProvincia;
    }

    /**
     * @param idProvincia the idProvincia to set
     */
    public void setIdProvincia(int idProvincia) {
        this.idProvincia = idProvincia;
    }

    /**
     * @return the descripcionLocalidad
     */
    public String getDescripcionLocalidad() {
        return descripcionLocalidad;
    }

    /**
     * @param descripcionLocalidad the descripcionLocalidad to set
     */
    public void setDescripcionLocalidad(String descripcionLocalidad) {
        this.descripcionLocalidad = descripcionLocalidad;
    }

    
}
