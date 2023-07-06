return {
  s(
    "modtest",
    fmt(
      [[
				#[cfg(test)]
				mod test {{
					{}
				}}
			]],
      {
        i(0),
      }
    )
  ),

  s(
    "test",
    fmt(
      [[
				#[test]
				fn {}() {{
					{}
				}}
			]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    "tokiotest",
    fmt(
      [[
				#[tokio::test]
				async fn {}() {{
					{}
				}}
			]],
      {
        i(1),
        i(0),
      }
    )
  ),
}
