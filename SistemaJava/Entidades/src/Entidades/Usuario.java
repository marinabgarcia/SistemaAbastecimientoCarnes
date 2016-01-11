/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Entidades;

import java.util.Date;

/**
 *
 * @author Hamal
 */
public class Usuario {
    private long dniUsuario;
    private String contraseña;
    private Date ultimaSesion;
    private String estadoUsuario;
    private String nombreUsuario;
    private String apellidoUsuario;
    private String direccionUsuario;
    private int localidadUsuario;
    private int provinciaUsuario;
    private String telefonoUsuario;
    private String celularUsuario;
    private String emailUsuario;
    private Date fechaAlta;
    private String fechaAltaS;
    private Date fechaBaja;
    private String fechaBajaS;
    private String fotoUsuario;
    private String dProvincia;
    private String dLocalidad;
    private String tipoUsuario;

    /**
     * @return the dniUsuario
     */
    public long getDniUsuario() {
        return dniUsuario;
    }

    /**
     * @param dniUsuario the dniUsuario to set
     */
    public void setDniUsuario(long dniUsuario) {
        this.dniUsuario = dniUsuario;
    }

    /**
     * @return the contraseña
     */
    public String getContraseña() {
        return contraseña;
    }

    /**
     * @param contraseña the contraseña to set
     */
    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    /**
     * @return the ultimaSesion
     */
    public Date getUltimaSesion() {
        return ultimaSesion;
    }

    /**
     * @param ultimaSesion the ultimaSesion to set
     */
    public void setUltimaSesion(Date ultimaSesion) {
        this.ultimaSesion = ultimaSesion;
    }

    /**
     * @return the estado
     */
    public String getEstado() {
        return estadoUsuario;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(String estado) {
        this.estadoUsuario = estado;
    }

    /**
     * @return the nombreUsuario
     */
    public String getNombreUsuario() {
        return nombreUsuario;
    }

    /**
     * @param nombreUsuario the nombreUsuario to set
     */
    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    /**
     * @return the apellidoUsuario
     */
    public String getApellidoUsuario() {
        return apellidoUsuario;
    }

    /**
     * @param apellidoUsuario the apellidoUsuario to set
     */
    public void setApellidoUsuario(String apellidoUsuario) {
        this.apellidoUsuario = apellidoUsuario;
    }

    /**
     * @return the direccionUsuario
     */
    public String getDireccionUsuario() {
        return direccionUsuario;
    }

    /**
     * @param direccionUsuario the direccionUsuario to set
     */
    public void setDireccionUsuario(String direccionUsuario) {
        this.direccionUsuario = direccionUsuario;
    }

    /**
     * @return the localidadUsuario
     */
    public int getLocalidadUsuario() {
        return localidadUsuario;
    }

    /**
     * @param localidadUsuario the localidadUsuario to set
     */
    public void setLocalidadUsuario(int localidadUsuario) {
        this.localidadUsuario = localidadUsuario;
    }

    /**
     * @return the provinciaUsuario
     */
    public int getProvinciaUsuario() {
        return provinciaUsuario;
    }

    /**
     * @param provinciaUsuario the provinciaUsuario to set
     */
    public void setProvinciaUsuario(int provinciaUsuario) {
        this.provinciaUsuario = provinciaUsuario;
    }

    /**
     * @return the telefonoUsuario
     */
    public String getTelefonoUsuario() {
        return telefonoUsuario;
    }

    /**
     * @param telefonoUsuario the telefonoUsuario to set
     */
    public void setTelefonoUsuario(String telefonoUsuario) {
        this.telefonoUsuario = telefonoUsuario;
    }

    /**
     * @return the celularUsuario
     */
    public String getCelularUsuario() {
        return celularUsuario;
    }

    /**
     * @param celularUsuario the celularUsuario to set
     */
    public void setCelularUsuario(String celularUsuario) {
        this.celularUsuario = celularUsuario;
    }

    /**
     * @return the emailUsuario
     */
    public String getEmailUsuario() {
        return emailUsuario;
    }

    /**
     * @param emailUsuario the emailUsuario to set
     */
    public void setEmailUsuario(String emailUsuario) {
        this.emailUsuario = emailUsuario;
    }

    /**
     * @return the fechaAlta
     */
    public Date getFechaAlta() {
        return fechaAlta;
    }

    /**
     * @param fechaAlta the fechaAlta to set
     */
    public void setFechaAlta(Date fechaAlta) {
        this.fechaAlta = fechaAlta;
    }

    /**
     * @return the fechaBaja
     */
    public Date getFechaBaja() {
        return fechaBaja;
    }

    /**
     * @param fechaBaja the fechaBaja to set
     */
    public void setFechaBaja(Date fechaBaja) {
        this.fechaBaja = fechaBaja;
    }

    /**
     * @return the fotoUsuario
     */
    public String getFotoUsuario() {
        return fotoUsuario;
    }

    /**
     * @param fotoUsuario the fotoUsuario to set
     */
    public void setFotoUsuario(String fotoUsuario) {
        this.fotoUsuario = fotoUsuario;
    }

    /**
     * @return the dProvincia
     */
    public String getdProvincia() {
        return dProvincia;
    }

    /**
     * @param dProvincia the dProvincia to set
     */
    public void setdProvincia(String dProvincia) {
        this.dProvincia = dProvincia;
    }

    /**
     * @return the dLocalidad
     */
    public String getdLocalidad() {
        return dLocalidad;
    }

    /**
     * @param dLocalidad the dLocalidad to set
     */
    public void setdLocalidad(String dLocalidad) {
        this.dLocalidad = dLocalidad;
    }

    /**
     * @return the tipoUsuario
     */
    public String getTipoUsuario() {
        return tipoUsuario;
    }

    /**
     * @param tipoUsuario the tipoUsuario to set
     */
    public void setTipoUsuario(String tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    /**
     * @return the fechaAltaS
     */
    public String getFechaAltaS() {
        return fechaAltaS;
    }

    /**
     * @param fechaAltaS the fechaAltaS to set
     */
    public void setFechaAltaS(String fechaAltaS) {
        this.fechaAltaS = fechaAltaS;
    }

    /**
     * @return the fechaBajaS
     */
    public String getFechaBajaS() {
        return fechaBajaS;
    }

    /**
     * @param fechaBajaS the fechaBajaS to set
     */
    public void setFechaBajaS(String fechaBajaS) {
        this.fechaBajaS = fechaBajaS;
    }
    
    
}
