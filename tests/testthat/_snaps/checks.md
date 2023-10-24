# check_npi() works

    Code
      check_npi(1234567891)
    Condition
      Error:
      ! An NPI must pass Luhn algorithm.
      x 1234567891 fails Luhn check.

---

    Code
      check_npi(12345691234)
    Condition
      Error:
      ! An NPI must be 10 digits long.
      x 12345691234 contains 11 digits.

---

    Code
      check_npi("O12345678912")
    Condition
      Error:
      ! An NPI must be numeric.
      x "O12345678912" contains non-numeric characters.

# validate_npi() works

    Code
      validate_npi(1234567891)
    Condition
      Error:
      ! "1234567891" is not a valid NPI.
      > Did you mean "1234567893"?

---

    Code
      validate_npi(12345691234)
    Condition
      Error:
      ! An NPI must be 10 digits long.
      x 12345691234 contains 11 digits.

---

    Code
      validate_npi("O12345678912")
    Condition
      Error:
      ! An NPI must be numeric.
      x "O12345678912" contains non-numeric characters.

# check_pac() works

    Code
      check_pac(123456789)
    Condition
      Error:
      ! A PAC ID must be 10 digits long.
      x 123456789 contains 9 digits.

---

    Code
      check_pac("O12345678912")
    Condition
      Error:
      ! A PAC ID must be numeric.
      x "O12345678912" contains non-numeric characters.

# check_enid() works

    Code
      check_enid(123456789123456)
    Condition
      Error:
      ! An Enrollment ID must be a <character> vector.
      x 123456789123456 is a <numeric> vector.

---

    Code
      check_enid("I123456789123456")
    Condition
      Error:
      ! An Enrollment ID must be 15 characters long.
      x "I123456789123456" contains 16 characters.

---

    Code
      check_enid("012345678912345")
    Condition
      Error:
      ! An Enrollment ID must be numeric.
      x "012345678912345" contains non-numeric characters.

---

    Code
      check_enid("L20031110000070")
    Condition
      Error:
      ! An Enrollment ID must begin with a capital `I` or `O`.
      x "L20031110000070" begins with "L".

---

    Code
      check_enid("I20031110000070", type = "org")
    Condition
      Error:
      ! An Organizational Enrollment ID must begin with a capital `O`.
      x "I20031110000070" begins with "I".

---

    Code
      check_enid("O20031110000070", type = "ind")
    Condition
      Error:
      ! An Individual Enrollment ID must begin with a capital `I`.
      x "O20031110000070" begins with "O".

