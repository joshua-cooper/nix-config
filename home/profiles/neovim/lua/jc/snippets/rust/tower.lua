return {
  s(
    "impltowerhandler",
    fmt(
      [[
				impl Service<Request<Body>> for {} {{
					type Response = Response<Body>;
					type Error = {};
					type Future = BoxFuture<'static, Result<Self::Response, Self::Error>>;

					fn poll_ready(&mut self, _cx: &mut Context<'_>) -> Poll<Result<(), Self::Error>> {{
						Poll::Ready(Ok(()))
					}}

					fn call(&mut self, req: Request<Body>) -> Self::Future {{
						{}
					}}
				}}
			]],
      {
        i(1),
        i(2, "Error"),
        i(0, "todo!()"),
      }
    )
  ),

  s(
    "impltowermw",
    fmt(
      [[
				impl<B, S> Service<Request<B>> for {}<S>
				where
					S: Service<Request<B>>,
				{{
					type Response = {};
					type Error = {};
					type Future = {};

					fn poll_ready(&mut self, cx: &mut Context<'_>) -> Poll<Result<(), Self::Error>> {{
						self.{}.poll_ready(cx)
					}}

					fn call(&mut self, req: Request<B>) -> Self::Future {{
						{}
					}}
				}}
			]],
      {
        i(1, "Middleware"),
        i(2, "S::Response"),
        i(3, "S::Error"),
        i(4, "S::Future"),
        i(5, "inner"),
        i(0, "todo!()"),
      }
    )
  ),

  s("towerresult", fmt("Result<Self::Response, Self::Error>{}", i(0))),
}
