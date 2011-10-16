

#Module abnfc#
* [Function Index](#index)
* [Function Details](#functions)






Copyright (c) 2009 Anders Nygren

__Authors:__ Anders Nygren ([`anders.nygren@gmail.com`](mailto:anders.nygren@gmail.com)).<a name="index"></a>

##Function Index##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#erlangcode-0">erlangcode/0</a></td><td><p>Scan erlang code.</p>.</td></tr><tr><td valign="top"><a href="#file-1">file/1</a></td><td><p>Compile an ABNF file.</p>.</td></tr><tr><td valign="top"><a href="#file-2">file/2</a></td><td><p>Compile an ABNF file.</p>.</td></tr><tr><td valign="top"><a href="#parse-1">parse/1</a></td><td><p>Parse a list or binary.</p>.</td></tr><tr><td valign="top"><a href="#parse-2">parse/2</a></td><td><p>Parse a list or binary.</p>.</td></tr></table>


<a name="functions"></a>

##Function Details##

<a name="erlangcode-0"></a>

###erlangcode/0##




<pre>erlangcode() -&gt; list()</pre>
<br></br>




<p>Scan erlang code.</p>
<a name="file-1"></a>

###file/1##




<pre>file(File::string()) -&gt; {ok, AST, Rest::binary()} | Error</pre>
<br></br>




<p>Compile an ABNF file.</p>
<a name="file-2"></a>

###file/2##




<pre>file(File::string(), Opts) -&gt; {ok, AST, Rest::binary()} | Error</pre>
<ul class="definitions"><li><pre>Opts = [Option]</pre></li><li><pre>Option = OutFile</pre></li><li><pre>OutFile = string()</pre></li></ul>



<p>Compile an ABNF file.</p>
<a name="parse-1"></a>

###parse/1##




<pre>parse(Bin::Text) -&gt; {ok, AST, Rest::binary()} | fail</pre>
<ul class="definitions"><li><pre>Text = list() | binary()</pre></li></ul>



<p>Parse a list or binary.</p>
<a name="parse-2"></a>

###parse/2##




<pre>parse(Bin::Text, Opts) -&gt; {ok, AST, Rest::list()} | fail</pre>
<ul class="definitions"><li><pre>Text = list() | binary()</pre></li></ul>



<p>Parse a list or binary.</p>
