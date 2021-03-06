functor Pattern (Abt : LIST_ABT) : PATTERN =
struct
  open Abt
  structure Ar = O.Ar
  structure Vl = Ar.Vl
  structure S = Vl.S

  datatype 'a argument =
      MVAR of metavariable
    | PAT of 'a
  and 'a view = $@ of operator * 'a argument spine

  datatype pattern = IN of pattern view * metactx

  infix $@

  structure Error =
  struct
    datatype t =
        NON_LINEAR
      | OTHER
  end

  exception InvalidPattern of Error.t

  structure MetaCtx = Metavar.Ctx and VarCtx = Var.Ctx
  structure CtxUtil = ContextUtil (structure Ctx = MetaCtx and Elem = Vl)

  fun extend psi (mv, vl) =
    CtxUtil.extend psi (mv, vl)
    handle CtxUtil.MergeFailure => raise InvalidPattern Error.NON_LINEAR

  fun concat (psi, psi') =
    CtxUtil.concat (psi, psi')
    handle CtxUtil.MergeFailure => raise InvalidPattern Error.NON_LINEAR

  fun into (theta $@ args) =
    let
      val (vls, tau) = O.arity theta
      fun go [] [] = MetaCtx.empty
        | go (MVAR mv :: args) (vl :: vls) = extend (go args vls) (mv, vl)
        | go (PAT p :: args) ((([], []), tau) :: vls) =
            let
              val (theta' $@ args', psi) = out p
              val (_, tau') = O.arity theta'
              val _ =
                if S.eq (tau, tau') then () else
                  raise InvalidPattern Error.OTHER
            in
              concat (go args vls, psi)
            end
        | go _ _ = raise InvalidPattern Error.OTHER
    in
      IN (theta $@ args, go args vls)
    end

  and out (IN p) = p
end
