def fixed_point_to_decimal(binary_num, precision, fractional_bits):
    """
    Convierte un número en punto fijo con complemento a 2 a decimal
    
    Args:
    binary_num (str): Número binario
    precision (int): Número total de bits
    fractional_bits (int): Número de bits para la parte fraccionaria
    
    Returns:
    float: Número decimal equivalente
    """
    # Asegurar que el número tenga la precisión correcta
    binary_num = binary_num.zfill(precision)[-precision:]
    
    # Separar parte entera y fraccionaria
    integer_bits = precision - fractional_bits
    integer_part = binary_num[:integer_bits]
    fractional_part = binary_num[integer_bits:]
    
    # Convertir parte entera (considerando complemento a 2)
    if integer_part[0] == '1':  # Número negativo
        # Calcular el complemento a 2 de la parte entera
        integer_value = -(2**integer_bits - int(integer_part, 2))
    else:
        integer_value = int(integer_part, 2)
    
    # Convertir parte fraccionaria
    fractional_value = 0
    for i, bit in enumerate(fractional_part):
        if bit == '1':
            fractional_value += 2**-(i+1)
    
    return integer_value + fractional_value

# Ejemplo con el número dado
binary_number = "11111010001"
precision = 16
fractional_bits = 5

result = fixed_point_to_decimal(binary_number, precision, fractional_bits)
print(f"Número binario: {binary_number}")
print(f"Precisión total: {precision} bits")
print(f"Bits fraccionarios: {fractional_bits} bits")
print(f"Resultado decimal: {result}")

# Mostrar el desglose
print("\nDesglose:")
print(f"Parte entera: {binary_number[:-fractional_bits]} ({precision-fractional_bits} bits)")
print(f"Parte fraccionaria: {binary_number[-fractional_bits:]} ({fractional_bits} bits)")