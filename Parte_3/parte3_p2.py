import numpy as np
import scipy.ndimage as nd
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator
import cv2 as cv
from scipy.signal import convolve2d

# Funcion de convolucion de dos dimensines para Python
def conv2(x, y, mode='same'):
    return np.rot90(convolve2d(np.rot90(x, 2), np.rot90(y, 2), mode=mode), 2)

# Importacion de bibliotecas matematica, manejo imagenes, graficado

## Tarea 3 parte 3
## Implementacion del algoritmo de Hough

# Creacion de las funciones im2double e im2uint8 por la falta de 
# equivalentes en Python
def im2double(im):
    info = np.iinfo(im.dtype) # Consiguie el tipo de dato de la imagen
    # Divide todos los valores por el maximo
    return im.astype(np.float64) / info.max 

def im2uint8(im):
    info = np.iinfo(np.uint8) # Consiguie el tipo de dato de la imagen
    # Multiplica por el valor maximo
    temp = im*info.max
    temp[temp>info.max] = info.max
    temp[temp<info.min] = info.min
    return temp.astype(np.uint8) 

# Definicion de la funcion binaria en python
def binaria(X):
    # Toma una imagen en blanco y negro y retorna una imagen de valores de 0 y 1
    # Entradas: - una imagen en blanco y negro.
    # Salidas: - una imagen binaria con valores de 0 o 1
    (m,n) = X.shape
    Y = np.zeros((m,n)).astype(np.bool8) # se utiliza el tipo booleano de 8 bits
    Y[X >= 0.5] = 1
    Y[X < 0.5] = 0
    return Y

"""
Extraccion de la gradiente morfologica de la imagen
  Realiza la operacion: (A dilatacion B) - (A erosion B)
  
Recibe: 
  - A: imagen binaria a extraer el borde
  - B: elemento estructurado en el cual realizar la extraccion
Retorna: 
  - E: imagen binaria con gradiente morfologica
"""
def grad_morf(A, B):
    # Aplicacion de la dilatacion binaria entre A y B
    C = nd.binary_dilation(A, B).astype(A.dtype)
    # Aplicacion de la erosion binaria entre A y B
    D = nd.binary_erosion(A, B).astype(A.dtype)
    # Primero se invierte logicamente D y luego se aplica la operacion and logico 
    E = np.logical_and(C, np.invert(D))

    return E

"""
Transformada de Hough para la deteccion de 
rectas en una imagen.
Entrada:
  - nombre_imagen:Imagen a procesar
Salida:
  - Grafico.
"""
def hough(B,m,n,p):
    P = np.zeros((m,n,p))

    (xi,yi) = np.where(B >= 0.5)

    for i in range(len(xi)):
        for a in range(1,m):
            for b in range(1,n):
                p1 = ((xi[i]) - a)**2
                p2 = ((yi[i]) - b)**2
                r = np.sqrt([p1 + p2])[0]
                if r != 0:
                    v_aux = 1/(2*np.pi*r)
                    r_ind = np.ceil(r).astype(int)
                    P[a,b,r_ind] += v_aux

    return P

## Lectura imagen 1
I1 = cv.imread('imagen1.png',0) # lectura de imagen de entrada
I1 = im2double(I1)
## Lectura imagen 2
I2 = cv.imread('imagen2.png',0) # lectura de imagen de entrada
I2 = im2double(I2)
## Lectura imagen 3
I3 = cv.imread('imagen3.png',0) # lectura de imagen de entrada
I3 = im2double(I3)

## Extraccion de bordes de la imagen

# Para obtener los bordes de la imagen, utilizaremos el operador de Sobel
# Bx = np.matrix([[-1,0,1],[-2,0,2],[-1,0,1]])
# By = np.matrix([[-1,-2,-1],[0,0,0],[1,2,1]])
# Cx = conv2(I,Bx,'same')
# Cy = conv2(I,By,'same')
# B = np.sqrt(np.add(np.power(Cx,2),np.power(Cy,2)))

## Imagen 1
B1 = cv.Canny(im2uint8(I1),300,400, apertureSize=3) # aplicacion del detector de bordes Canny
# La deteccion de bordes con Canny ya aplica la limpieza con el filtro Gauss
B1 = im2double(B1)
# Convertirla a Binaria
B1 = binaria(B1) # pasar a binario a los bordes B1

## Imagen 2
B2 = cv.Canny(im2uint8(I2),300,400, apertureSize=3) # aplicacion del detector de bordes Canny
# La deteccion de bordes con Canny ya aplica la limpieza con el filtro Gauss
B2 = im2double(B2)
# Convertirla a Binaria
B2 = binaria(B2) # pasar a binario a los bordes B2

## Imagen 3
B3 = cv.Canny(im2uint8(I3),300,400, apertureSize=3) # aplicacion del detector de bordes Canny
# La deteccion de bordes con Canny ya aplica la limpieza con el filtro Gauss
B3 = im2double(B3)
# Convertirla a Binaria
B3 = binaria(B3) # pasar a binario a los bordes B

## Limpieza

# Creacion del elemento estructurado
# EE = np.matrix([[0,1,0],[1,1,1],[0,1,0]], B.dtype)
# EE = np.ones((2,2), B1.dtype)
# B1 = nd.binary_erosion(B1, EE).astype(B1.dtype)

## Parametros del algoritmo

## Imagen 1
(M1,N1) = I1.shape # extraccion de dimensiones
# Asignacion de parametros segun el algoritmo de deteccion de circulos
m1 = M1
n1 = N1
p1 = np.ceil(np.sqrt([M1**2 + N1**2])).astype(int)[0]

## Imagen 2
(M2,N2) = I2.shape # extraccion de dimensiones
# Asignacion de parametros segun el algoritmo de deteccion de circulos
m2 = M2
n2 = N2
p2 = np.ceil(np.sqrt([M2**2 + N2**2])).astype(int)[0]

## Imagen 3
(M3,N3) = I3.shape # extraccion de dimensiones
# Asignacion de parametros segun el algoritmo de deteccion de circulos
m3 = M3
n3 = N3
p3 = np.ceil(np.sqrt([M3**2 + N3**2])).astype(int)[0]

## Aplicacion del algoritmo de deteccion de circulos

## Imagen 1
P1 = hough(B1,m1,n1,p1)
## Imagen 2
P2 = hough(B2,m2,n2,p2)
## Imagen 3
P3 = hough(B3,m3,n3,p3)

## Especificacion del limite para tomar en cuenta
## Imagen 1
(X1,Y1,R1) = np.where(P1 > 0.45)
## Imagen 2
(X2,Y2,R2) = np.where(P2 > 0.45)
## Imagen 3
(X3,Y3,R3) = np.where(P3 > 0.45)

## Creando la imagen de salida en ceros
## Imagen 1
out_img1 = np.zeros((M1,N1), dtype=np.uint8)
## Imagen 2
out_img2 = np.zeros((M2,N2), dtype=np.uint8)
## Imagen 3
out_img3 = np.zeros((M3,N3), dtype=np.uint8)


## Creacion de circulos detectados

## Imagen 1
for i in range(len(X1)):
    # Coordenadas centro
    cc = (Y1[i],X1[i])
    # Radio del
    radio = R1[i]
    # Using cv2.circle() method
    # Draw a circle with blue line borders of thickness of 2 px
    out_img1 = cv.circle(out_img1, cc, radio, 255, 1)
    # out_img[X[i],Y[i]] = 255

## Imagen 2
for i in range(len(X2)):
    # Coordenadas centro
    cc = (Y2[i],X2[i])
    # Radio del
    radio = R2[i]
    # Using cv2.circle() method
    # Draw a circle with blue line borders of thickness of 2 px
    out_img2 = cv.circle(out_img2, cc, radio, 255, 1)
    # out_img[X[i],Y[i]] = 255
 
## Imagen 3
for i in range(len(X3)):
    # Coordenadas centro
    cc = (Y3[i],X3[i])
    # Radio del
    radio = R3[i]
    # Using cv2.circle() method
    # Draw a circle with blue line borders of thickness of 2 px
    out_img3 = cv.circle(out_img3, cc, radio, 255, 1)
    # out_img[X[i],Y[i]] = 255

## Graficacion

## Imagen 1
plt.subplot(331) # posicion de la cuadro
plt.imshow(I1, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Imagen Original 1')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(332) # posicion de la cuadro
plt.imshow(B1, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Deteccion Bordes 1')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(333) # posicion de la cuadro
plt.title("Extraccion Circulos Hough 1") 
plt.imshow(out_img1, cmap='gray', vmin = 0, vmax = 255, interpolation='none')
plt.xticks([])
plt.yticks([])

## Imagen 2

plt.subplot(334) # posicion de la cuadro
plt.imshow(I2, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Imagen Original 2')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(335) # posicion de la cuadro
plt.imshow(B2, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Deteccion Bordes 2')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(336) # posicion de la cuadro
plt.title("Extraccion Circulos Hough 2") 
plt.imshow(out_img2, cmap='gray', vmin = 0, vmax = 255, interpolation='none')
plt.xticks([])
plt.yticks([])

## Imagen 3

plt.subplot(337) # posicion de la cuadro
plt.imshow(I3, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Imagen Original 3')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(338) # posicion de la cuadro
plt.imshow(B3, cmap = 'gray', vmin = 0, vmax = 1, interpolation='none')
plt.title('Deteccion Bordes 3')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])

plt.subplot(339) # posicion de la cuadro
plt.title("Extraccion Circulos Hough 3") 
plt.imshow(out_img3, cmap='gray', vmin = 0, vmax = 255, interpolation='none')
plt.xticks([])
plt.yticks([])


## Guardar imagen
plt.imsave('resultado_imagen1.png', out_img1)
plt.imsave('resultado_imagen2.png', out_img2)
plt.imsave('resultado_imagen3.png', out_img3)

# Muestra la ventana con un bloqueo
plt.show()