import Data.List
{-Begin Question 2.1-}
-- Combines list of ints into one int
number :: [Int] -> Int
number = foldl addDigit 0
   where addDigit num d = 10*num + d


{-End Question 2.1-}

{-Begin Question 2.2-}
-- Splits list into all non-trivial pairs
splits :: [a] -> [([a],[a])]
splits [] = []
splits [x] = []
splits (x : xs) = ([x], xs) : map f (splits xs)
  where
    f (z, y) = (x : z, y)

-- Outputs all possible combinations
possibles :: [([Int],[Int])]
possibles
  = concatMap splits (permutations [1,2..9])

{-End Question 2.2-}

{-Begin Question 2.3-}
isAcceptable :: ([Int],[Int]) -> Bool
isAcceptable x
  | not (isPalindrome (multiplyNums x)) = False
  | not (checkFirst (multiplyNums x)) = False
  | not (findSmallest x) = False
  | otherwise = True

-- Converts an int to a list of ints
digits :: Int -> [Int]
digits 0
  = []
digits num
  = digits (num `div` 10) ++ [num `mod` 10]

-- Multiplies two numbers, and returns a list of ints (which is the product) so it can be processed by other functions
multiplyNums :: ([Int], [Int]) -> [Int]
multiplyNums (x,y)
  = digits ((number x) * (number y))


-- Checks if a list of numbers is a palindrome
isPalindrome :: Eq a => [a] -> Bool
isPalindrome w 
  = w == reverse w

-- Check if first digit is a 4
checkFirst :: [Int] -> Bool
checkFirst (x:xs)
  = x == 4

-- Check if its last digit of the smallest int is a three
findSmallest :: ([Int], [Int]) -> Bool
findSmallest (x,y)
  | ((length x) < (length y)) && ((last x) == 3) = True
  | ((length y) < (length x)) && ((last y) == 3) = True
  | otherwise = False

-- Finds all acceptable palindromes
acceptables :: [([Int],[Int])]
acceptables
  = possiblesConsumer possibles

-- Consumes possibles and outputs all that are acceptible
possiblesConsumer :: [([Int], [Int])] -> [([Int], [Int])]
possiblesConsumer []
  = []
possiblesConsumer (x:xs)
  | isAcceptable x = x : possiblesConsumer xs
  | otherwise = possiblesConsumer xs

{-End Question 2.3-}

-- any main functions for testing goes here