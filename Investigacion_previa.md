# Investigación Previa: Sistema para Papelería Tradicional

## 1. Funcionamiento del Tipo de Negocio Elegido

El modelo operativo de una papelería urbana se basa en el comercio minorista (retail) de alta frecuencia transaccional. Funciona mediante la adquisición de artículos escolares, de oficina y de tecnología a distribuidores mayoristas, para su venta directa al cliente final.

Desde la perspectiva de análisis de sistemas, el modelo opera como un sistema de flujo continuo donde las entradas (inputs) son la recepción de nueva mercancía y actualizaciones de catálogos, y las salidas (outputs) son las transacciones de venta, prestación de servicios y decrementos del stock. 

Una característica crítica y particular de este negocio es el manejo de una gran variedad de entidades (miles de SKUs) con atributos dinámicos (venta por unidad o caja) y la comercialización de servicios "intangibles" (copias, escaneos, engargolados) que carecen de código de barras físico y requieren captura especial en el sistema.

## 2. Identificación de Procesos Básicos (Reglas Funcionales)

A continuación se desglosan los procesos operativos fundamentales que sustentan el negocio:

### A. Proceso de Ventas (Transacciones y Mostrador)
El flujo del proceso inicia cuando el cliente se presenta a mostrador. El cajero captura los ítems (mediante lectura de código de barras o búsqueda predictiva de texto). El sistema debe realizar un cálculo en tiempo real del subtotal, aplicar reglas lógicas de negocio (como descuentos por caja o mayoreo), sumar impuestos y totalizar. Una vez completado el cobro, la transacción finaliza (commit) garantizando la atomicidad, generando un ticket y actualizando el inventario instantáneamente.

### B. Control e Integridad de Inventario (Gestión de Stock)
Es el proceso responsable de mantener la coherencia de los datos en almacén. Involucra el alta, baja y modificación de artículos. Una funcionalidad clave es el manejo de "umbrales y disparadores" (triggers lógicos); el sistema debe ser capaz de rastrear constantemente las salidas por ventas y, cuando un artículo alcanza su nivel mínimo programado, emitir alertas de reabastecimiento para el administrador del local. También regula el registro de mermas (productos dañados o devueltos).

### C. Atención al Cliente y Soporte de Servicios Externos
A diferencia del inventario físico, la papelería provee servicios que pueden considerarse de "stock infinito" dentro del software (ej. impresiones a color, renta de computadoras, copias fotostáticas). El proceso para atender al cliente requiere una interfaz que permita tabular precios dinámicamente según variables de entrada (por ejemplo: `Total a pagar = PrecioBase * NumeroPáginas`).

### D. Gestión de Pagos, Cortes de Caja y Arqueo Diario
Este proceso centraliza el flujo de ingresos. Acepta múltiples métodos de entrada (efectivo, tarjeta, transferencias). Al concluir un turno activo (cierre de la sesión de usuario del empleado), se ejecuta un proceso de auditoría conocido como "corte en Z" o arqueo de caja. El sistema recolecta y cruza todas las transacciones generadas por ese usuario contra los fondos físicos, asegurando que no haya discrepancias financieras antes del logout.
