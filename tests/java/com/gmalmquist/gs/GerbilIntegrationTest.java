package com.gmalmquist.gs;

import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

import org.junit.Test;
import static org.junit.Assert.*;


public class GerbilIntegrationTest {

  private GerbilScriptParser getParser(InputStream in) throws Exception {
    ANTLRInputStream input = new ANTLRInputStream(in);
    GerbilScriptLexer lexer = new GerbilScriptLexer(input);
    CommonTokenStream tokens = new CommonTokenStream(lexer);
    GerbilScriptParser parser = new GerbilScriptParser(tokens);
    return parser;
  }

  private void assertFileInLanguage(String name) {
    InputStream in = null;
    try {
      in = getClass().getResourceAsStream("/com/gmalmquist/gs/" + name);
      if (in == null) { 
        System.err.println("File does not exist '" + name + "'.");
        ClassLoader cl = ClassLoader.getSystemClassLoader();
        System.err.println(java.util.Arrays.toString(((java.net.URLClassLoader)cl).getURLs()));
        return;
      }
    } catch (Exception e) {
      System.err.println("File does not exist '" + name + "'.");
      return;
    }
    try {
      GerbilScriptParser parser = getParser(in);
      ParseTree tree = parser.start();
      String text = tree.toStringTree(parser);
      boolean missing = text.matches(".*?[<]missing '.*?'>.*");
      if (missing) {
        System.err.println(text);
      }
      assertFalse(text, missing);
    } catch (Exception e) {
      e.printStackTrace();
      assertTrue(e.getMessage(), false);
    }
  }

  @Test
  public void testSimpleMath() {
    assertFileInLanguage("simple_math.js");
  }

  @Test
  public void testSimpleFunctions() {
    assertFileInLanguage("simple_functions.js");
  }

  @Test
  public void testSampleForIn() {
    assertFileInLanguage("sample_forin.js");
  }

  @Test
  public void testSampleWhile() {
    assertFileInLanguage("sample_while.js");
  }

  @Test
  public void testSampleTryCatch() {
    assertFileInLanguage("sample_trycatch.js");
  }

  @Test
  public void testClass() {
    assertFileInLanguage("sample_class.js");
  }

}
