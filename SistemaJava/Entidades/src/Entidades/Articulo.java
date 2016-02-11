/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entidades;

/**
 *
 * @author Marina
 */
public class Articulo {

    private int idArticulo;
    private String descripcionArticulo;
    private int stockUnidad;
    private double pesoEstimadoArticulo;
    private String estadoArticulo;
    private int idCalidad;
    //para mostrar en la tabla la descripcion
    private String descripcionCalidad;
    private double montoPrecioCompra; 
    private double montoPrecioVenta; 
    private int cantidadFraccionada;
    private double stockPeso;

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
     * @return the descripcionArticulo
     */
    public String getDescripcionArticulo() {
        return descripcionArticulo;
    }

    /**
     * @param descripcionArticulo the descripcionArticulo to set
     */
    public void setDescripcionArticulo(String descripcionArticulo) {
        this.descripcionArticulo = descripcionArticulo;
    }

    /**
     * @return the estadoArticulo
     */
    public String getEstadoArticulo() {
        return estadoArticulo;
    }

    /**
     * @param estadoArticulo the estadoArticulo to set
     */
    public void setEstadoArticulo(String estadoArticulo) {
        this.estadoArticulo = estadoArticulo;
    }

    /**
     * @return the pesoEstimadoArticulo
     */
    public double getPesoEstimadoArticulo() {
        return pesoEstimadoArticulo;
    }

    /**
     * @param pesoEstimadoArticulo the pesoEstimadoArticulo to set
     */
    public void setPesoEstimadoArticulo(double pesoEstimadoArticulo) {
        this.pesoEstimadoArticulo = pesoEstimadoArticulo;
    }

    /**
     * @return the stockUnidad
     */
    public int getStockUnidad() {
        return stockUnidad;
    }

    /**
     * @param stockUnidad the stockUnidad to set
     */
    public void setStockUnidad(int stockUnidad) {
        this.stockUnidad = stockUnidad;
    }

    /**
     * @return the idCalidad
     */
    public int getIdCalidad() {
        return idCalidad;
    }

    /**
     * @param idCalidad the idCalidad to set
     */
    public void setIdCalidad(int idCalidad) {
        this.idCalidad = idCalidad;
    }

    /**
     * @return the descripcionCalidad
     */
    public String getDescripcionCalidad() {
        return descripcionCalidad;
    }

    /**
     * @param descripcionCalidad the descripcionCalidad to set
     */
    public void setDescripcionCalidad(String descripcionCalidad) {
        this.descripcionCalidad = descripcionCalidad;
    }

    /**
     * @return the precioCompra
     */
    public double getMontoPrecioCompra() {
        return montoPrecioCompra;
    }

    /**
     * @param precioCompra the precioCompra to set
     */
    public void setMontoPrecioCompra(double precioCompra) {
        this.montoPrecioCompra = precioCompra;
    }

    /**
     * @return the cantidadFraccionada
     */
    public int getCantidadFraccionada() {
        return cantidadFraccionada;
    }

    /**
     * @param cantidadFraccionada the cantidadFraccionada to set
     */
    public void setCantidadFraccionada(int cantidadFraccionada) {
        this.cantidadFraccionada = cantidadFraccionada;
    }

    /**
     * @return the stockPeso
     */
    public double getStockPeso() {
        return stockPeso;
    }

    /**
     * @param stockPeso the stockPeso to set
     */
    public void setStockPeso(double stockPeso) {
        this.stockPeso = stockPeso;
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

    
    
}
