import math

def base_n_to_decimal(number, base):
    """
    Convert a number from base n to decimal (base 10), including fractional parts.

    :param number: The number to convert (as a string).
    :param base: The base of the input number (2 to 36).
    :return: The decimal (base 10) equivalent of the input number.
    """
    # Separar la parte entera y la parte fraccionaria
    if '.' in number:
        integer_part, fractional_part = number.split('.')
    else:
        integer_part, fractional_part = number, ''

    # Convertir la parte entera a decimal
    decimal_value = 0
    length = len(integer_part)
    for i, digit_char in enumerate(integer_part):
        if digit_char.isdigit():
            digit = int(digit_char)
        else:
            digit = ord(digit_char.upper()) - ord('A') + 10
        position = length - i - 1
        decimal_value += digit * (base ** position)

    # Convertir la parte fraccionaria a decimal
    if fractional_part:
        for i, digit_char in enumerate(fractional_part):
            if digit_char.isdigit():
                digit = int(digit_char)
            else:
                digit = ord(digit_char.upper()) - ord('A') + 10
            position = -(i + 1)
            decimal_value += digit * (base ** position)

    return decimal_value

# Ejemplo de uso
number = "-11110.111"
base = 2

decimal_number = base_n_to_decimal(number, base)
integer_part = int(decimal_number)  # Parte entera del decimal

# Calcular bits necesarios
if integer_part == 0:
    bits = 1  # Caso especial para 0
else:   
    bits = math.floor(math.log2(integer_part)) + 1

print(f"The decimal (base 10) equivalent of {number} (base {base}) is: {decimal_number}")
print(f"Bits needed to represent the integer part ({integer_part}): {bits}")