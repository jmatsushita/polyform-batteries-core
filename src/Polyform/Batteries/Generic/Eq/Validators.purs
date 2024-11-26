module Polyform.Batteries.Generic.Eq.Validators where

import Prelude

import Data.Array (elem) as Array
import Polyform.Batteries (Validator', error) as Batteries
import Polyform.Validator (check) as Validator
import Prim.Row (class Cons) as Row
import Type.Prelude (class IsSymbol)

type NotEqualToErr a
  = { expected ∷ a, got ∷ a }

equalTo ∷
  ∀ a err err' @l m.
  Row.Cons l (NotEqualToErr a) err err' ⇒
  IsSymbol l ⇒
  Eq a ⇒
  Applicative m ⇒
  (NotEqualToErr a → String) →
  a →
  Batteries.Validator' m err' a a
equalTo msg expected = Validator.check (Batteries.error @l msg <<< { expected, got: _ }) (_ == expected)

differentThan ∷
  ∀ a err err' @l m.
  Row.Cons l a err err' ⇒
  IsSymbol l ⇒
  Eq a ⇒
  Applicative m ⇒
  (a → String) →
  a →
  Batteries.Validator' m err' a a
differentThan msg a = Validator.check (const $ Batteries.error @l msg a) (_ /= a)

type NotOneOfErr a
  = { expected ∷ Array a, got ∷ a }

oneOf ∷
  ∀ a err err' @l m.
  Row.Cons l (NotOneOfErr a) err err' ⇒
  IsSymbol l ⇒
  Eq a ⇒
  Applicative m ⇒
  (NotOneOfErr a → String) →
  Array a →
  Batteries.Validator' m err' a a
oneOf msg arr = Validator.check (Batteries.error @l msg <<< { expected: arr, got: _ }) (_ `Array.elem` arr)

type NotMissingFromErr a
  = { unexpected ∷ Array a, got ∷ a }

missingFrom ∷
  ∀ a err err' @l m.
  Row.Cons l (NotMissingFromErr a) err err' ⇒
  IsSymbol l ⇒
  Eq a ⇒
  Applicative m ⇒
  (NotMissingFromErr a → String) →
  Array a →
  Batteries.Validator' m err' a a
missingFrom msg arr = Validator.check (Batteries.error @l msg <<< { unexpected: arr, got: _ }) (not <<< flip Array.elem arr)
