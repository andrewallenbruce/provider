# npi_check() works

    Code
      npi_check(1234567891)
    Error <rlang_error>
      An NPI must pass Luhn algorithm.
      x 1234567891 fails Luhn check.

---

    Code
      npi_check(12345691234)
    Error <rlang_error>
      An NPI must be 10 digits long.
      x 12345691234 contains 11 digits.

---

    Code
      npi_check("O12345678912")
    Error <rlang_error>
      An NPI must be numeric.
      x "O12345678912" contains non-numeric characters.

# pac_check() works

    Code
      pac_check(123456789)
    Error <rlang_error>
      A PAC ID must be 10 digits long.
      x 123456789 contains 9 digits.

---

    Code
      pac_check("O12345678912")
    Error <rlang_error>
      A PAC ID must be numeric.
      x "O12345678912" contains non-numeric characters.

# enroll_check() works

    Code
      enroll_check(123456789123456)
    Error <rlang_error>
      An Enrollment ID must be a <character> vector.
      x 123456789123456 is a <numeric> vector.

---

    Code
      enroll_check("I123456789123456")
    Error <rlang_error>
      An Enrollment ID must be 15 characters long.
      x "I123456789123456" contains 16 characters.

---

    Code
      enroll_check("012345678912345")
    Error <rlang_error>
      An Enrollment ID must begin with a capital `I` or `O`.
      x "012345678912345" begins with "0".

# enroll_org_check() works

    Code
      enroll_org_check("I20031110000070")
    Error <rlang_error>
      An org/group Enrollment ID must begin with a capital `O`.
      x "I20031110000070" begins with "I".

# enroll_ind_check() works

    Code
      enroll_ind_check("O20031110000070")
    Error <rlang_error>
      An individual Enrollment ID must begin with a capital `I`.
      x "O20031110000070" begins with "O".

