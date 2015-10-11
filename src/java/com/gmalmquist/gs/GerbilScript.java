package com.gmalmquist.gs;

import org.apache.commons.io.IOUtils;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;


public class GerbilScript {

  public static void main(String[] args) throws Exception {
    System.out.println("Up and running.");
    String source = "var x = 7 * 3.4*-.2/6 + #FFF - 0t1220;";

    ANTLRInputStream input = null;
    input = new ANTLRInputStream(IOUtils.toInputStream(source, "UTF-8"));
    //input = new ANTLRInputStream(GerbilScript.class.getResourceAsStream("simple_math.js"));
    GerbilScriptLexer lexer = new GerbilScriptLexer(input);
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    GerbilScriptParser parser = new GerbilScriptParser(tokens);
    ParseTree tree = parser.start();

    System.out.println(tree.toStringTree(parser));
  }

}
