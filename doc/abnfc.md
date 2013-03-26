

# Module abnfc #
* [Function Index](#index)
* [Function Details](#functions)

Copyright (c) 2009 Anders Nygren

__Authors:__ Anders Nygren ([`anders.nygren@gmail.com`](mailto:anders.nygren@gmail.com)).
<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#erlangcode-0">erlangcode/0</a></td><td>Scan erlang code.</td></tr><tr><td valign="top"><a href="#file-1">file/1</a></td><td>Compile an ABNF file.</td></tr><tr><td valign="top"><a href="#file-2">file/2</a></td><td>Compile an ABNF file.</td></tr><tr><td valign="top"><a href="#parse-1">parse/1</a></td><td>Parse a list or binary.</td></tr><tr><td valign="top"><a href="#parse-2">parse/2</a></td><td>Parse a list or binary.</td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="erlangcode-0"></a>

### erlangcode/0 ###


<pre><code>
erlangcode() -&gt; list()
</code></pre>

<br></br>


Scan erlang code.
<a name="file-1"></a>

### file/1 ###


<pre><code>
file(File::string()) -&gt; {ok, AST, Rest::binary()} | Error
</code></pre>

<br></br>


Compile an ABNF file.
<a name="file-2"></a>

### file/2 ###


<pre><code>
file(File::string(), Opts) -&gt; {ok, AST, Rest::binary()} | Error
</code></pre>

<ul class="definitions"><li><code>Opts = [Option]</code></li><li><code>Option = OutFile</code></li><li><code>OutFile = string()</code></li></ul>

Compile an ABNF file.
<a name="parse-1"></a>

### parse/1 ###


<pre><code>
parse(Bin::Text) -&gt; {ok, AST, Rest::binary()} | fail
</code></pre>

<ul class="definitions"><li><code>Text = list() | binary()</code></li></ul>

Parse a list or binary.
<a name="parse-2"></a>

### parse/2 ###


<pre><code>
parse(Bin::Text, Opts) -&gt; {ok, AST, Rest::list()} | fail
</code></pre>

<ul class="definitions"><li><code>Text = list() | binary()</code></li></ul>

Parse a list or binary.
