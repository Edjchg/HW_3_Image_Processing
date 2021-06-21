import numpy as np
import scipy.ndimage as nd
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator
import cv2 as cv

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

# """
# Transformada de Hough para la deteccion de 
# rectas en una imagen.
# Entrada:
#     nombre_imagen:Imagen a procesar
# #Salida:
#     Grafico.
# """
def hough(B,m,n,p):
    P = np.zeros((m,n,p))

    (xi,yi) = np.where(B == 1)

    for i in range(len(xi)):
        for a in range(1,m):
            for b in range(1,n):
                p1 = ((xi[i]) - a)**2
                p2 = ((yi[i]) - b)**2
                r = np.sqrt([p1 + p2])[0]
                if r != 0:
                    v_aux = 1/(2*np.pi*r)
                    r_ind = np.ceil(r).astype(int)
                    P[a-1,b-1,r_ind-1] += v_aux

    return P

I = cv.imread('imagen1.png',0) # lectura de imagen de entrada
B = cv.Canny(I,350,400) # aplicacion del detector de bordes Canny
# La deteccion de bordes con Canny ya aplica la limpieza con el filtro Gauss
B = binaria(im2double(B)) # pasar a binario a los bordes B
(M,N) = I.shape # extraccion de dimensiones
# Asignacion de parametros segun el algoritmo de deteccion de circulos
m = M
n = N
p = np.ceil(np.sqrt([M**2 + N**2])).astype(int)[0]

# Aplicacion del algoritmo de deteccion de circulos
P = hough(B,m,n,p)

print(np.where(P > 0.55))

# fig, ax = plt.subplots(subplot_kw={"projection": "3d"})

# # Make data.
# X = np.arange(0, m, 1)
# Y = np.arange(0, n, 1)
# X, Y = np.meshgrid(X, Y)
# R = np.sqrt(X**2 + Y**2)
# Z = np.sin(R)

# Plot the surface.
# surf = ax.plot_surface(X, Y, P, cmap=cm.coolwarm,
#                        linewidth=0, antialiased=False)

# # Customize the z axis.
# ax.set_zlim(-1.01, 1.01)
# ax.zaxis.set_major_locator(LinearLocator(10))
# # A StrMethodFormatter is used automatically
# ax.zaxis.set_major_formatter('{x:.02f}')

# Add a color bar which maps values to colors.
# fig.colorbar(surf, shrink=0.5, aspect=5)

# plt.show()

plt.subplot(121) # posicion de la cuadro
plt.imshow(I,cmap = 'gray')
plt.title('Imagen Original')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])
plt.subplot(122)
plt.imshow(im2uint8(B),cmap = 'gray')
plt.title('Deteccion Bordes Canny')
# Se vacian los ejes
plt.xticks([])
plt.yticks([])
# Muestra la ventana con un bloqueo
plt.show()