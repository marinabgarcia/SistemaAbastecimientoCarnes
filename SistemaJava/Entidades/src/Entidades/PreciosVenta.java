/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

import java.sql.Date;

/**
 *
 * @author Hamal
 */
public class PreciosVenta {

    private int idArticulo;
    private Date fechaDesde;
    private Date fechaHasta;
    private int idTipoCliente;
    private double montoPrecioVenta;
    private String descripcionTipoCliente;

    /**
     * @return the idArticulo
     */
    public int getIdArticulo() {
        return idArticulo;
    }

    /**
     * @param idArticulo the idArticulo to set
     */
    public void setIdArticulo(int idArticulo) {
        this.idArticulo = idArticulo;
    }

    /**
     * @return the fechaDesde
     */
    public Date getFechaDesde() {
        return fechaDesde;
    }

    /**
     * @param fechaDesde the fechaDesde to set
     */
    public void setFechaDesde(Date fechaDesde) {
        this.fechaDesde = fechaDesde;
    }

    /**
     * @return the fechaHasta
     */
    public Date getFechaHasta() {
        return fechaHasta;
    }

    /**
     * @param fechaHasta the fechaHasta to set
     */
    public void setFechaHasta(Date fechaHasta) {
        this.fechaHasta = fechaHasta;
    }

    /**
     * @return the idTipoCliente
     */
    public int getIdTipoCliente() {
        return idTipoCliente;
    }

    /**
     * @param idTipoCliente the idTipoCliente to set
     */
    public void setIdTipoCliente(int idTipoCliente) {
        this.idTipoCliente = idTipoCliente;
    }

    /**
     * @return the montoPrecioVenta
     */
    public double getMontoPrecioVenta() {
        return montoPrecioVenta;
    }

    /**
     * @param montoPrecioVenta the montoPrecioVenta to set
     */
    public void setMontoPrecioVenta(double montoPrecioVenta) {
        this.montoPrecioVenta = montoPrecioVenta;
    }

    /**
     * @return the descripcionTipoCliente
     */
    public String getDescripcionTipoCliente() {
        return descripcionTipoCliente;
    }

    /**
     * @param descripcionTipoCliente the descripcionTipoCliente to set
     */
    public void setDescripcionTipoCliente(String descripcionTipoCliente) {
        this.descripcionTipoCliente = descripcionTipoCliente;
    }
}
