<%@ page import="virlib.Document; org.springframework.util.ClassUtils" %>
<%@ page import="grails.plugin.searchable.internal.lucene.LuceneUtils" %>
<%@ page import="grails.plugin.searchable.internal.util.StringQueryUtils" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <meta name="layout" content="main">
    <script type="text/javascript">
        var focusQueryInput = function () {
            document.getElementById("q").focus();
        }
    </script>
</head>

<body style="text-align: left" onload="focusQueryInput();">

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
    </ul>
</div>

<div align="left" style="margin-left: 20px; margin-right: 30px; text-align: justify" id="content"><font face="Verdana, Geneva, sans-serif" size="2">
<h1>SOPAC DIVISION VIRTUAL LIBRARY</h1>

<p style="font-size: 14px">Advanced Query Syntax</p>
<br/>

<div id="minitoc-area">
    <ul>
        <li><a href="#Overview">Overview</a></li>
        <li><a href="#Terms">Terms</a></li>
        <li><a href="#Fields">Fields</a></li>
        <li><a href="#Term Modifiers">Term Modifiers</a>
            <ul>
                <li><a href="#Wildcard Searches">Wildcard
                Searches</a></li>
                <li><a href="#Fuzzy Searches">Fuzzy
                Searches</a></li>
                <li><a href="#Proximity Searches">Proximity
                Searches</a></li>
                <li><a href="#Range Searches">Range
                Searches</a></li>
                <li><a href="#Boosting a Term">Boosting a
                Term</a></li>
            </ul>
        </li>
        <li><a href="#Boolean operators">Boolean
        Operators</a>
            <ul>
                <li><a style="margin-left: 20px" href="#AND">AND</a></li>
                <li><a style="margin-left: 20px" href="#+">+</a></li>
                <li><a style="margin-left: 20px" href="#NOT">NOT</a></li>
                <li><a style="margin-left: 20px" href="#-">-</a></li>
            </ul>
        </li>
        <li><a href="#Grouping">Grouping</a></li>
        <li><a href="#Field Grouping">Field Grouping</a>
        </li>
        <li><a href="#Escaping Special Characters">Escaping
        Special Characters</a></li>
    </ul>
</div>
<br/>

<a name="N10013" id="N10013"></a><a name="Example" id="Example"></a>
<b>Examples</b>
<br/>
author:"Robert Smith" and title:Multibeam
<br/>
title:Snapshot AND content:"Pacific Disaster Net Training"
<br/>
title:Disaster AND publicationMonth:May


<br/>
<br/>
<a name="N10013" id="N10013"></a><a name="Overview" id="Overview"></a>
<b>Overview</b>

<div>
    <p>SOPAC VirLib Search Engine provides the ability to create your own queries through its rich and fairly advanced
    query language.</p>

    <p>This page provides the Query Parser syntax in VirLib Search Engine.</p>

</div>

<br/>
<a name="N10032" id="N10032"></a><a name="Terms" id="Terms"></a>
<b>Terms</b>

<div>
    <p>A query is broken up into terms and operators. There are two types of terms: Single Terms and Phrases.</p>

    <p>A Single Term is a single word such as &quot;test&quot; or &quot;hello&quot;.</p>

    <p>A Phrase is a group of words surrounded by double quotes such as &quot;hello dolly&quot;.</p>

    <p>Multiple terms can be combined together with Boolean operators to form a more complex query (see below).</p>

    <p>Note: The analyzer used to create the index will be used on the terms and phrases in the query string. So it
    is important to choose an analyzer that will not interfere with the terms used in the query string.</p>
</div>
<br/>
<a name="N10048" id="N10048"></a><a name="Fields" id="Fields"></a>
<b>Fields</b>

<div>
    <p>VirLib Search Engine supports fielded data. When performing a search you can either specify a field, or use the default
    field. The field names and default field is implementation specific.</p>

    <p>You can search any field by typing the field name followed by a colon &quot;:&quot; and then the term you are
    looking for.</p>

    <p>As an example, let's assume a VirLib Search Engine index contains two fields, title and text and text is the default field.
    If you want to find the document entitled &quot;The Right Way&quot; which contains the text &quot;don't go
    this way&quot;, you can enter:</p>
    <pre>title:&quot;The Right Way&quot; AND author:go</pre>

    <p>or</p>
    <pre>title:&quot;Do it right&quot; AND right</pre>

    <p>Since text is the default field, the field indicator is not required.</p>

    <p>Note: The field is only valid for the term that it directly precedes, so the query</p>
    <pre>title:Do it right</pre>

    <p>Will only find &quot;Do&quot; in the title field. It will find &quot;it&quot; and &quot;right&quot; in the
    default field (in this case the text field).</p>
    <br/>

    <p>Query-able fields are as follows :</p>
    <br/>
    <i>
        String reportId<br/>
        number<br/>
        title<br/>
        author<br/>
        file<br/>
        size<br/>
        noOfPages<br/>
        created<br/>
        content<br/>
        publicationMonth<br/>
        publicationYear<br/>
    </i>

</div>
<br/>
<a name="N1006D" id="N1006D"></a><a name="Term Modifiers" id="Term Modifiers"></a>
<b>Term Modifiers</b>

<div>
    <p>VirLib Search Engine supports modifying query terms to provide a wide range of searching options.</p>
    <br/>
    <a name="N10076" id="N10076"></a><a name="Wildcard Searches" id="Wildcard Searches"></a>

    <b>Wildcard Searches</b>

    <p>VirLib Search Engine supports single and multiple character wildcard searches within single terms (not within phrase
    queries).</p>

    <p>To perform a single character wildcard search use the &quot;?&quot; symbol.</p>

    <p>To perform a multiple character wildcard search use the &quot;*&quot; symbol.</p>

    <p>The single character wildcard search looks for terms that match that with the single character replaced. For
    example, to search for &quot;text&quot; or &quot;test&quot; you can use the search:</p>
    <pre>te?t</pre>

    <p>Multiple character wildcard searches looks for 0 or more characters. For example, to search for test, tests
    or tester, you can use the search:</p>
    <pre>test*</pre>

    <p>You can also use the wildcard searches in the middle of a term.</p>
    <pre>te*t</pre>

    <p>Note: You cannot use a * or ? symbol as the first character of a search.</p>
    <br/>
    <a name="N1009B" id="N1009B"></a><a name="Fuzzy Searches" id="Fuzzy Searches"></a>
    <b>Fuzzy Searches</b>

    <p>VirLib Search Engine supports fuzzy searches based on the Levenshtein Distance, or Edit Distance algorithm. To do a fuzzy
    search use the tilde, &quot;~&quot;, symbol at the end of a Single word Term. For example to search for a
    term similar in spelling to &quot;roam&quot; use the fuzzy search:</p>
    <pre>roam~</pre>

    <p>This search will find terms like foam and roams.</p>

    <p>Starting with VirLib Search Engine 1.9 an additional (optional) parameter can specify the required similarity. The value is
    between 0 and 1, with a value closer to 1 only terms with a higher similarity will be matched. For
    example:</p>
    <pre>roam~0.8</pre>

    <p>The default that is used if the parameter is not given is 0.5.</p>
    <br/>
    <a name="N100B4" id="N100B4"></a><a name="Proximity Searches" id="Proximity Searches"></a>
    <b>Proximity Searches</b>

    <p>VirLib Search Engine supports finding words are a within a specific distance away. To do a proximity search use the tilde,
    &quot;~&quot;, symbol at the end of a Phrase. For example to search for a &quot;lala&quot; and &quot;robert&quot;
    within 10 words of each other in a document use the search:</p>
    <pre>&quot;robert smith&quot;~10</pre>
    <br/>
    <a name="N100C1" id="N100C1"></a><a name="Range Searches" id="Range Searches"></a>
    <b>Range Searches</b>

    <p>Range Queries allow one to match documents whose field(s) values are between the lower and upper bound
    specified by the Range Query. Range Queries can be inclusive or exclusive of the upper and lower bounds.
    Sorting is done lexicographically.</p>
    <pre>mod_date:[20020101 TO 20030101]</pre>

    <p>This will find documents whose mod_date fields have values between 20020101 and 20030101, inclusive. Note
    that Range Queries are not reserved for date fields. You could also use range queries with non-date
    fields:</p>
    <pre>title:{Aida TO Carmen}</pre>

    <p>This will find all documents whose titles are between Aida and Carmen, but not including Aida and Carmen.</p>

    <p>Inclusive range queries are denoted by square brackets. Exclusive range queries are denoted by curly
    brackets.</p>
    <br/>
    <a name="N100DA" id="N100DA"></a><a name="Boosting a Term" id="Boosting a Term"></a>
    <b>Boosting a Term</b>

    <p>VirLib Search Engine provides the relevance level of matching documents based on the terms found. To boost a term use the
    caret, &quot;^&quot;, symbol with a boost factor (a number) at the end of the term you are searching. The
    higher the boost factor, the more relevant the term will be.</p>

    <p>Boosting allows you to control the relevance of a document by boosting its term. For example, if you are
    searching for</p>
    <pre>robert smith</pre>

    <p>and you want the term &quot;robert&quot; to be more relevant boost it using the ^ symbol along with the
    boost factor next to the term. You would type:</p>
    <pre>robert^4 lala</pre>

    <p>This will make documents with the term robert appear more relevant. You can also boost Phrase Terms as in
    the example:</p>
    <pre>&quot;robert smith&quot;^4 &quot;lala&quot;</pre>

    <p>By default, the boost factor is 1. Although the boost factor must be positive, it can be less than 1 (e.g.
    0.2)</p>
</div>
<br/>

<a name="N100FA" id="N100FA"></a><a name="Boolean operators" id="Boolean operators"></a>
<b>Boolean Operators</b>

<div>
    <p>Boolean operators allow terms to be combined through logic operators. VirLib Search Engine supports AND, &quot;+&quot;, OR,
    NOT and &quot;-&quot; as Boolean operators(Note: Boolean operators must be ALL CAPS).</p>
    <a name="N10103" id="N10103"></a><a name="OR" id="OR"></a>

    <h3></h3>

    <p>The OR operator is the default conjunction operator. This means that if there is no Boolean operator between
    two terms, the OR operator is used. The OR operator links two terms and finds a matching document if either
    of the terms exist in a document. This is equivalent to a union using sets. The symbol || can be used in
    place of the word OR.</p>

    <p>To search for documents that contain either &quot;robert smith&quot; or just &quot;robert&quot; use the
    query:</p>
    <pre>&quot;robert smith&quot; robert</pre>

    <p>or</p>
    <pre>&quot;robert smith&quot; OR robert</pre>
    <a name="N10116" id="N10116"></a><a name="AND" id="AND"></a>

    <b>AND</b>

    <p>The AND operator matches documents where both terms exist anywhere in the text of a single document. This is
    equivalent to an intersection using sets. The symbol &amp;&amp; can be used in place of the word AND.</p>

    <p>To search for documents that contain &quot;robert smith&quot; and &quot;lala&quot; use the
    query:</p>
    <pre>&quot;robert smith&quot; AND &quot;lala&quot;</pre>
    <a name="N10126" id="N10126"></a><a name="+" id="+"></a>

    <b>+</b>

    <p>The &quot;+&quot; or required operator requires that the term after the &quot;+&quot; symbol exist somewhere
    in a the field of a single document.</p>

    <p>To search for documents that must contain &quot;robert&quot; and may contain &quot;multibeam&quot; use the
    query:</p>
    <pre>+robert multibeam</pre>
    <a name="N10136" id="N10136"></a><a name="NOT" id="NOT"></a>

    <b>NOT</b>

    <p>The NOT operator excludes documents that contain the term after NOT. This is equivalent to a difference using
    sets. The symbol ! can be used in place of the word NOT.</p>

    <p>To search for documents that contain &quot;robert smith&quot; but not &quot;lala&quot; use the
    query:</p>
    <pre>&quot;robert smith&quot; NOT &quot;lala&quot;</pre>

    <p>Note: The NOT operator cannot be used with just one term. For example, the following search will return no
    results:</p>
    <pre>NOT &quot;robert smith&quot;</pre>
    <a name="N1014C" id="N1014C"></a><a name="-" id="-"></a>

    <b>-</b>

    <p>The &quot;-&quot; or prohibit operator excludes documents that contain the term after the &quot;-&quot;
    symbol.</p>

    <p>To search for documents that contain &quot;robert smith&quot; but not &quot;lala&quot; use the
    query:</p>
    <pre>&quot;robert smith&quot; -&quot;lala&quot;</pre>
</div>

<br/>
<a name="N1015D" id="N1015D"></a><a name="Grouping" id="Grouping"></a>
<b>Grouping</b>

<div>
    <p>VirLib Search Engine supports using parentheses to group clauses to form sub queries. This can be very useful if you want
    to control the boolean logic for a query.</p>

    <p>To search for either &quot;robert&quot; or &quot;lala&quot; and &quot;website&quot; use the query:</p>
    <pre>(robert OR lala) AND website</pre>

    <p>This eliminates any confusion and makes sure you that website must exist and either term robert or lala
    may exist.</p>
</div>

<br/>
<a name="N10170" id="N10170"></a><a name="Field Grouping" id="Field Grouping"></a>
<b>Field Grouping</b>

<div>
    <p>VirLib Search Engine supports using parentheses to group multiple clauses to a single field.</p>

    <p>To search for a title that contains both the word &quot;return&quot; and the phrase &quot;pink panther&quot;
    use the query:</p>
    <pre>title:(+return +&quot;pink panther&quot;)</pre>
</div>

<br/>
<a name="N10180" id="N10180"></a><a name="Escaping Special Characters" id="Escaping Special Characters"></a>
<b>Escaping Special Characters</b>

<div>
    <p>VirLib Search Engine supports escaping special characters that are part of the query syntax. The current list special
    characters are</p>

    <p>+ - &amp;&amp; || ! ( ) { } [ ] ^ &quot; ~ * ? : \</p>

    <p>To escape these character use the \ before the character. For example to search for (1+1):2 use the
    query:</p>
    <pre>\(1\+1\)\:2</pre>
</div>
</font></div>

</body>
</html>
