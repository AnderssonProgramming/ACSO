def binary_to_ieee754(binary):
    """
    Convierte un número binario en formato IEEE-754 de 32 bits a su valor decimal.
    
    Parámetros:
        binary (str): El número binario en formato de cadena (32 bits).
    
    Retorna:
        float: El valor decimal correspondiente.
    """
    # Verificar que la longitud del binario sea 32 bits
    if len(binary) != 32:
        raise ValueError("El número binario debe tener 32 bits.")
    
    # Extraer el signo, exponente y mantisa
    sign_bit = int(binary[0])  # Primer bit es el signo
    exponent_bits = binary[1:9]  # Siguientes 8 bits son el exponente
    mantissa_bits = binary[9:]  # Últimos 23 bits son la mantisa
    
    # Convertir el exponente a decimal y aplicar el bias
    exponent = int(exponent_bits, 2) - 127  # Bias de 127 para IEEE-754
    
    # Convertir la mantisa a decimal fraccional
    mantissa = 1  # Se añade el 1 implícito
    for i, bit in enumerate(mantissa_bits):
        mantissa += int(bit) * (2 ** -(i + 1))
    
    # Calcular el valor decimal
    value = (-1) ** sign_bit * mantissa * (2 ** exponent)
    
    return value


# Ejemplo de uso
binary_ieee754 = "101011.11011"  # Número binario en formato IEEE-754
result = binary_to_ieee754(binary_ieee754)
print(f"El valor decimal es: {result}")