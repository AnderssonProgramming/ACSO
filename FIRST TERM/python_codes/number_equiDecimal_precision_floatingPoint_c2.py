def binary_to_float(binary, precision, exponent_bits, bias):
    """
    Convierte un número binario en punto flotante a su equivalente decimal.
    
    Parámetros:
        binary (str): El número binario en formato de cadena.
        precision (int): La precisión total en bits.
        exponent_bits (int): Número de bits para el exponente.
        bias (int): El valor del bias para el exponente.
    
    Retorna:
        float: El valor decimal correspondiente.
    """
    # Verificar que la longitud del binario coincida con la precisión
    if len(binary) != precision:
        raise ValueError(f"La longitud del binario debe ser {precision} bits.")
    
    # Extraer el signo, exponente y mantisa
    sign_bit = int(binary[0])  # Primer bit es el signo
    exponent_bits_str = binary[1:1 + exponent_bits]  # Bits del exponente
    mantissa_bits_str = binary[1 + exponent_bits:]  # Bits de la mantisa
    
    # Convertir el exponente a decimal y aplicar el bias
    exponent = int(exponent_bits_str, 2) - bias
    
    # Convertir la mantisa a decimal fraccional
    mantissa = 0
    for i, bit in enumerate(mantissa_bits_str):
        mantissa += int(bit) * (2 ** -(i + 1))
    
    # Calcular el valor decimal
    value = (-1) ** sign_bit * (1 + mantissa) * (2 ** exponent)
    
    return value


# Parámetros del problema
binary = "1100111110101"  # Número binario
precision = 13  # Precisión total en bits
exponent_bits = 5  # Número de bits para el exponente
bias = 16  # Bias para el exponente

# Convertir a decimal
result = binary_to_float(binary, precision, exponent_bits, bias)
print(f"El valor decimal es: {result/2}")