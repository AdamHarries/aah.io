# Linear Algebra, Semirings and Graph Theory

In most applications of linear algebra, such as geometry or linear programming, the elements which make up the matrices, vectors and scalars in the linear system are drawn from either the set of real numbers, $\mathbb{R}$, or the set of integers, $\mathbb{Z}$. It is possible, however, to draw the elements from any valid _semiring_. A semiring is a formal structure from the world of abstract algebra, which allows for a set of operations to be defined on a set, such that any formula using such operations can also operate on the elements of the underlying set of the semiring. This allows many seemingly unrelated problems to be recast in terms of linear algebra (for some examples in the Haskell programming language, see \citet{Dolan:2013:FSF:2500365.2500613}). Two of the algorithms discussed later in the thesis do exactly this, hence our discussion of semirings here.

Formally, a semiring is a set $S$, equipped with two binary operations $\oplus$ and $\otimes$, known as addition and multiplication along with a zero element, $0$, the additive identity, and multiplicative annihilator, and a one element $1$, the multiplicative identity element. For any three elements $a,b,c\in S$, the properties given in Equation \ref{equation:ring_axioms} must hold over the semiring on $S$.

<!-- $$ -->
\begin{align}

(a \oplus b) \oplus c &= a \oplus (b \oplus c) && \text{additive associativity}\\
0 \oplus a &= a \oplus 0 = a && \text{additive identity}\\
a \oplus b &= b \oplus a  && \text{additive commutativity}\\
(a \otimes b) \otimes c &= a \otimes (b \otimes c) && \text{multiplicative associativity}\\
1 \otimes a &= a \otimes 1 = a && \text{multiplicative identity}\\
a \otimes (b \oplus c) &= (a \otimes b) \oplus (a \otimes c) && \text{multiplicative distributivity}\\
(a \oplus b) \otimes c &= (a \otimes c) \oplus (b \otimes c) && \text{multiplicative distributivity}\\
0 \otimes a &= a \otimes 0 = 0 && \text{multiplicative annihilation}\\
\end{align}

<!-- $$ -->


In the usual definition of linear algebra, the set $S$ is chosen to be either the set of real numbers or the set of integers ($\mathbb{R}$ or $\mathbb{Z}$), and the ordinary arithmetic operations $+$ and $\times$ are chosen as the addition and multiplication operators.

For convenience we will denote a semiring as a 5-tuple, formed of the underlying set, and two lambda expressions representing, respectively, the addition and multiplication operations (where the arguments to the operation are obvious, the lambda will be omitted) and the zero and one element. For example, the standard arithmetic semiring on the real numbers is denoted as follows:

$$ (\; \mathbb{R}\ ,\ +\ ,\ \times\ ,\ 0\ ,\ 1\; ) $$
