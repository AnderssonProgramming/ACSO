def binario_a_base_n(numero_binario: str, base_n: int) -> str:
    """
    Convierte un número binario (base 2) a una base arbitraria (base N).

    :param numero_binario: Cadena que representa el número en binario.
    :param base_n: Base de destino (entre 2 y 36).
    :return: Cadena que representa el número en la base de destino.
    """
    if not (2 <= base_n <= 36):
        raise ValueError("La base de destino debe estar entre 2 y 36.")

    # Convertir el número binario a decimal (base 10)
    numero_decimal = int(numero_binario, 2)

    # Caracteres para representar dígitos en bases hasta 36
    caracteres = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    # Convertir de decimal a la base de destino
    resultado = ""
    while numero_decimal > 0:
        residuo = numero_decimal % base_n
        resultado = caracteres[residuo] + resultado
        numero_decimal //= base_n

    return resultado or "0"

# Ejemplo de uso
numero_binario = '1100011101'  # Número en binario
base_n = 16  # Base de destino
representacion_en_base_n = binario_a_base_n(numero_binario, base_n)
print(f"El número {numero_binario} en binario es {representacion_en_base_n} en base {base_n}.")
