def convert_to_base(number: float, base: float) -> str:
    if base <= 1:
        raise ValueError("La base debe ser mayor que 1.")
    
    # Manejar el signo
    sign = "-" if number < 0 else ""
    number = abs(number)
    
    # Convertir la parte entera
    integer_part = int(number)
    fractional_part = number - integer_part
    
    # Parte entera a base `base`
    integer_representation = ""
    if integer_part == 0:
        integer_representation = "0"
    else:
        while integer_part > 0:
            integer_part, remainder = divmod(integer_part, int(base))
            integer_representation = str(remainder) + integer_representation

    # Parte decimal a base `base`
    fractional_representation = ""
    precision = 10  # Limitar la precisión para fracciones periódicas
    
    for _ in range(precision):
        fractional_part *= base
        digit = int(fractional_part)
        fractional_representation += str(digit)
        fractional_part -= digit
        if fractional_part == 0:
            break

    # Formatear el resultado
    if fractional_representation:
        return f"{sign}{integer_representation}.{fractional_representation}"
    return f"{sign}{integer_representation}"


# Ejemplo de uso
number = 243.52
base = 5
result = convert_to_base(number, base)
print(f"{number} en base {base} es {result}")
