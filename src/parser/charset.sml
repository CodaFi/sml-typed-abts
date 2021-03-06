structure EmptyCharSet :> CHARSET =
struct
  val char = CharParser.satisfy (fn _ => false)
end

structure GreekCharSet :> CHARSET =
struct
  val chars =
    "\206\177" (* α *)
    ^ "\206\178" (* β *)
    ^ "\206\147" (* Γ *)
    ^ "\206\179" (* γ *)
    ^ "\206\148" (* Δ *)
    ^ "\206\180" (* δ *)
    ^ "\206\181" (* ε *)
    ^ "\206\182" (* ζ *)
    ^ "\206\183" (* η *)
    ^ "\206\147" (* Θ *)
    ^ "\206\184" (* θ *)
    ^ "\206\185" (* ι *)
    ^ "\206\186" (* κ *)
    ^ "\206\155" (* Λ *)
    ^ "\206\187" (* λ *)
    ^ "\206\188" (* μ *)
    ^ "\206\189" (* ν *)
    ^ "\206\158" (* Ξ *)
    ^ "\206\190" (* ξ *)
    ^ "\206\160" (* Π *)
    ^ "\207\128" (* π *)
    ^ "\207\129" (* ρ *)
    ^ "\206\163" (* Σ *)
    ^ "\207\131" (* σ *)
    ^ "\207\132" (* τ *)
    ^ "\207\133" (* υ *)
    ^ "\206\166" (* Φ *)
    ^ "\207\134" (* φ *)
    ^ "\207\135" (* χ *)
    ^ "\206\168" (* Ψ *)
    ^ "\207\136" (* ψ *)
    ^ "\206\169" (* Ω *)
    ^ "\207\137" (* ω *)

  val char = CharParser.oneOf (String.explode chars)
end
