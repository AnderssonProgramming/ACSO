def to_decimal(number, base):
    """Convierte un número en cualquier base a decimal"""
    if isinstance(number, str):
        return int(number, base)
    return number

def to_binary(decimal_num, precision=8):
    """Convierte un número decimal a binario con precisión específica"""
    if decimal_num >= 0:
        binary = bin(decimal_num)[2:].zfill(precision)
    else:
        # Para números negativos, usamos complemento a 2
        positive = bin(abs(decimal_num))[2:].zfill(precision)
        # Invertir bits
        inverted = ''.join('1' if bit == '0' else '0' for bit in positive)
        # Sumar 1
        binary = bin(int(inverted, 2) + 1)[2:].zfill(precision)
    return binary[-precision:]

def subtract_complement_2(num1, base1, num2, base2, precision=6):
    """
    Realiza la resta usando complemento a 2
    num1, num2: números en sus respectivas bases (como strings)
    base1, base2: bases de los números (2, 8, 10, 16, 32, etc.)
    precision: cantidad de bits para el resultado
    """
    # Convertir ambos números a decimal
    decimal1 = to_decimal(num1, base1)
    decimal2 = to_decimal(num2, base2)
    
    # Realizar la resta
    result = decimal1 - decimal2
    
    # Convertir el resultado a binario usando complemento a 2
    binary_result = to_binary(result, precision)
    
    return binary_result

# Ejemplo de uso para el caso específico
num1 = "110111"  # Base 32
num2 = "72"  # Base 16

result = subtract_complement_2(num1, 3, num2, 9, 12)
print(f"Resultado en binario (complemento a 2): {result}")

# Convertir el resultado a decimal para verificación
decimal_result = int(result, 2)
if decimal_result >= 2**(6-1):  # Si el primer bit es 1 (número negativo)
    decimal_result -= 2**6
print(f"Resultado en decimal: {decimal_result}")