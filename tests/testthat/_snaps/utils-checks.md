# npi_check() works

    Code
      npi_check(1234567891)
    Condition
      Error:
      ! An NPI must pass Luhn algorithm.
      x 1234567891 fails Luhn check.

---

    Code
      npi_check(12345691234)
    Condition
      Error:
      ! An NPI must be 10 digits long.
      x 12345691234 contains 11 digits.

---

    Code
      npi_check("O12345678912")
    Condition
      Error:
      ! An NPI must be numeric.
      x "O12345678912" contains non-numeric characters.

# pac_check() works

    Code
      pac_check(123456789)
    Condition
      Error:
      ! A PAC ID must be 10 digits long.
      x 123456789 contains 9 digits.

---

    Code
      pac_check("O12345678912")
    Condition
      Error:
      ! A PAC ID must be numeric.
      x "O12345678912" contains non-numeric characters.

# enroll_check() works

    Code
      enroll_check(123456789123456)
    Condition
      Error:
      ! An Enrollment ID must be a <character> vector.
      x 123456789123456 is a <numeric> vector.

---

    Code
      enroll_check("I123456789123456")
    Condition
      Error:
      ! An Enrollment ID must be 15 characters long.
      x "I123456789123456" contains 16 characters.

---

    Code
      enroll_check("012345678912345")
    Condition
      Error:
      ! An Enrollment ID must begin with a capital `I` or `O`.
      x "012345678912345" begins with "0".

# enroll_org_check() works

    Code
      enroll_org_check("I20031110000070")
    Condition
      Error:
      ! An org/group Enrollment ID must begin with a capital `O`.
      x "I20031110000070" begins with "I".

# enroll_ind_check() works

    Code
      enroll_ind_check("O20031110000070")
    Condition
      Error:
      ! An individual Enrollment ID must begin with a capital `I`.
      x "O20031110000070" begins with "O".

