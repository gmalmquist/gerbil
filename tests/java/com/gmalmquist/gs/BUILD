target(name='gs',
  dependencies=[
    ':integration',
  ],
)

junit_tests(name='integration',
  sources=['GerbilIntegrationTest.java'],
  dependencies=[':common'],
  resources=['src/resources/com/gmalmquist/gs'],
)

target(name='common',
  dependencies=[
    '3rdparty:apache-commons-io',
    '3rdparty:junit',
    'src/antlr/com/gmalmquist/gs',
    'src/java/com/gmalmquist/gs',
    'src/resources/com/gmalmquist/gs',
  ],
)
