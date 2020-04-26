from sage.crypto.util import ascii_to_bin

def hashFunction(message):
    """
    The Hash Function which takes in a message and outputs a hash value as a 2x2 matrix product.
    INPUT: The message to be hashed.
    OUTPUT: The matrix product which is our 'hashed' value.
    """
    binaryMessage = ascii_to_bin(message)
    matrixProduct = Matrix()

    #Comparasion does not recognise a 0,1 int or string.
    varA = binaryMessage[0]
    if binaryMessage[0] == varA:
        matrixProduct = matrixA
    else:
        matrixProduct = matrixB

    for i in range(1, len(binaryMessage)):
        if binaryMessage[i] == varA:
            matrixProduct = matrixProduct*matrixA
        else:
            matrixProduct = matrixProduct*matrixB
    return matrixProduct

### 0: SET UP THESE VARIABLES BEFORE STARTING PROGRAM!
print "Setting up field..."
n = 10
p = 7
degreef = 1
fileName = 'randomstringsbig5.txt'

### 1: Set up the field with a random irreducible polynomial as a modulus.
x = var('x')
K.<x> = GF(p^n, modulus='random')
#K.<x> = GF(p^n, modulus=x^2 + x + 1)  <--- Uncomment this line if you want a specific modulus.
print "Field created of type: ", type(K)
X = K.modulus()
print "Modulus of field: ", X

### 2: Get two random polynomials from F_p[x].
y = var('y')
G = GF(p)[y]
f = G.irreducible_element(1,"random");
f2 = G.irreducible_element(1,"random");
f = f.subs(x) - f.subs(0) # f and f tilde are supposed to have zero constant terms.
f2 = f2.subs(x) - f2.subs(0)
#f = x <--- Uncomment these lines if you want specific values.
#f2 = x
print "f value is:", f
print "\ftilde value is:", f2

### 3: Set up Matrix A and Matrix B.
matrixA = Matrix([[f,0],[0,1]])
matrixB = Matrix([[f2+1,1-f2],[1-f2,f2+1]])

### 4: Set up messages list by reading them in from text file.
with open('fileName', 'r') as f:
    messages = [l.strip() for l in f.readlines()]

### 5: Set up variables for hashing messages.
hashs = []
collisions = 0
count = 0
messagesLength = len(messages)
print("Hashing all input data...")

# For each message in the list of messages, hash the value and append it to the output hashs list.
for message in messages:
    count += 1
    if(count % 1000 == 0):
        print "Currently at:", count, "/", messagesLength, " - collisions = ", collisions
    hash = hashFunction(message);
    if(hash in hashs):
        collisions += 1
    hashs.append(hash)

### 6: Output the number of collisions observed.
print "Number of collisions:", collisions









