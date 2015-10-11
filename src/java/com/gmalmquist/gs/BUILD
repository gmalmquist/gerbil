java_library(name='gs',
  sources=rglobs('*.java'),
  dependencies=[
    '3rdparty:apache-commons-io',
    'src/antlr/com/gmalmquist/gs',
  ],
)

jvm_binary(name='bin',
  dependencies=[':gs'],
  main='com.gmalmquist.gs.GerbilScript',
)

jvm_binary(name='grun',
  dependencies=[':gs'],
  main='org.antlr.v4.runtime.misc.TestRig',
)
