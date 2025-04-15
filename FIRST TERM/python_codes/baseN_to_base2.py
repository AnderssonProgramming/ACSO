def convertir_a_binario(numero: str, base: int) -> str:
    """
    Convierte un número de una base arbitraria a su representación en binario.

    :param numero: Cadena que representa el número en la base original.
    :param base: Base del número original (entre 2 y 36).
    :return: Cadena que representa el número en binario.
    """
    if not (2 <= base <= 36):
        raise ValueError("La base debe estar entre 2 y 36.")

    # Convertir el número de la base original a decimal (base 10)
    numero_decimal = int(numero, base)

    # Convertir el número decimal a binario y eliminar el prefijo '0b'
    numero_binario = bin(numero_decimal)[2:]

    return numero_binario

# Ejemplo de uso
numero = '-30.875'  # Número en base 8
base = 10
representacion_binaria = convertir_a_binario(numero, base)
print(f"El número {numero} en base {base} es {representacion_binaria} en binario.")
