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
public class PreciosCompra {
    private int idArticulo;
    private Date fechaDesde;
    private Date fechaHasta;
    private long cuitProveedor;
    private double montoPrecioCompra;
    private String nombreProveedor;

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
     * @return the cuitProveedor
     */
    public long getCuitProveedor() {
        return cuitProveedor;
    }

    /**
     * @param cuitProveedor the cuitProveedor to set
     */
    public void setCuitProveedor(long cuitProveedor) {
        this.cuitProveedor = cuitProveedor;
    }

    /**
     * @return the montoPrecioCompra
     */
    public double getMontoPrecioCompra() {
        return montoPrecioCompra;
    }

    /**
     * @param precio the montoPrecioCompra to set
     */
    public void setMontoPrecioCompra(double precio) {
        this.montoPrecioCompra = precio;
    }

    /**
     * @return the nombreProveedor
     */
    public String getNombreProveedor() {
        return nombreProveedor;
    }

    /**
     * @param nombreProveedor the nombreProveedor to set
     */
    public void setNombreProveedor(String nombreProveedor) {
        this.nombreProveedor = nombreProveedor;
    }
}
