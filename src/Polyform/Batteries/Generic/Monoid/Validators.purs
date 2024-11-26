module Polyform.Batteries.Generic.Monoid.Validators where

import Prelude

import Polyform.Batteries (Validator')
import Polyform.Batteries (error) as Batteries
import Polyform.Validator (check) as Validator
import Prim.Row (class Cons) as Row
import Type.Prelude (class IsSymbol)

isEmpty ∷
  ∀ a err err' @l m.
  Row.Cons l a err err' ⇒
  IsSymbol l ⇒
  Eq a ⇒
  Monoid a ⇒
  Applicative m ⇒
  (a → String) →
  Validator' m err' a a
isEmpty msg = Validator.check (Batteries.error @l msg) (_ == mempty)

isNotEmpty ∷
  ∀ a err err' @l m.
  Row.Cons l Unit err err' ⇒
  IsSymbol l ⇒
  Monoid a ⇒
  Eq a ⇒
  Applicative m ⇒
  (a → String) →
  Validator' m err' a a
isNotEmpty msg = Validator.check (\e → Batteries.error @l (const (msg e)) unit) (_ /= mempty)
