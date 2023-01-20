-- any imports go here
import Data.List
{-Begin Question 1.1-}

digits :: Int -> [Int]
digits 0
  = []
digits num
  = digits (num `div` 10) ++ [num `mod` 10]

{-End Question 1.1-}

{-Begin Question 1.2-}

-- Combines each two numbers in a list to make a two digit number
numCombine :: [ Int ] -> [ Int ]
numCombine []
  = []
numCombine (x:y:xs)
  = x * 10 + y : numCombine xs

-- Checks if second number in a list is a multple of another
checkMultiple :: [ Int ] -> Bool
checkMultiple (x:y:xs)
  | y `mod` x == 0 = True
  | otherwise = False

-- Check for duplicates
duplicateCheck :: [ Int ] -> Bool
duplicateCheck []
  = False
duplicateCheck (x:xs)
  | x `elem` xs = True
  | otherwise = duplicateCheck xs

-- Checks for a PAR number
isPar :: Int -> Bool
isPar x
  | 0 `elem` (digits x) = False
  | duplicateCheck (digits x) = False
  | otherwise = checkMultiple (numCombine (digits x))

-- Produces numbers to be tested against isPar
parProducer :: [Int]
parProducer
  = [1111,1112..9999]

-- Concatenates all the pars
parConcatenate :: [ Int ] -> [ Int ]
parConcatenate []
  = []
parConcatenate (x:xs)
  | isPar x = x : parConcatenate xs
  | otherwise = parConcatenate xs

-- Finds all PAR numbers
pars :: [Int]
pars
  = parConcatenate parProducer

{-End Question 1.2-}

{-Begin Question 1.3-}

-- Finds the missing number in the two PARs
missingNum :: [ Int ] -> Int -> Int
missingNum xs 9
  = 9
missingNum xs n
  | n `notElem` xs = n
  | otherwise = missingNum xs (n+1)

-- Checks that the two PARs are multiples of missing number
notMultiple :: (Int, Int) -> Bool
notMultiple (x, y)
  | x `mod` mN == 0 && y `mod` mN == 0 = False
  | otherwise = True
  where
    mN = missingNum (digits (x * 10000 + y)) 1

-- Checks if two PARs are a party
isParty :: (Int, Int) -> Bool
isParty (x, y)
  | duplicateCheck (digits (x * 10000 + y)) = False
  | notMultiple (x, y) = False
  | otherwise = True


-- Combines List of List into one list of pairings
combineN :: [[(Int, Int)]] -> [(Int, Int)]
combineN ls = [a | l <- ls, a <- l]

-- For each par it is combined with all others, in both possible pairings
pairOne :: Int -> [Int] -> [(Int, Int)]
pairOne x []
  = []
pairOne x (y:ys)
  = (x, y) : (y, x) : pairOne x ys

-- Pairs all pars to all others
pairAll :: [ Int ] -> [ [(Int, Int)] ]
pairAll []
  = []
pairAll (x:xs)
  = pairOne x xs : pairAll xs

-- Producer to create all possible par pairings
partyProducer :: [(Int, Int)]
partyProducer
  = combineN (pairAll pars)

-- Consumer checks all possible party combinations, and combines them to a list
partysChecker :: [(Int, Int)] -> [(Int, Int)]
partysChecker []
  = []
partysChecker (x:xs)
  | isParty x = x : partysChecker xs
  | otherwise = partysChecker xs

partys :: [(Int, Int)]
partys
  = partysChecker partyProducer

{-End Question 1.3-}

-- any main functions for testing goes here