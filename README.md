<div align="center">
  <!-- <img src="https://helm.sh/img/helm.svg" title="Helm" alt="Helm" width="256" height="256" style="filter: url(#glow);" /> -->

<svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="0">
  <defs>
    <filter id="glow">
      <feGaussianBlur stdDeviation="15" result="coloredBlur"/>
      <feMerge>
        <feMergeNode in="coloredBlur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
</svg>

<link href="https://fonts.googleapis.com/css?family=Onest&display=swap" rel="stylesheet">

<h1 style="font-family: Onest, monospace; color: black; ">RelaySpark ⚡</h1>
<h6>Collection of pipeline jobs coded in three musketeers pattern.</h6>

</div>

---

# Introduction

Pipeline are essential to implementing the  automation of DevOps practices and frameworks. They power the core automation in which our workflows run, and has been a staple to the DevOps implementation of organizations, big or small.

Maintaining a reusable pipeline and jobs speeds up the development process and automation. However as of the moment, there are no single tool that unifies definition of pipeline across different platforms and CI/CD tools.

**RelaySpark** offers a way to define pipelines and reusable jobs you can use to make your pipeline reusable. RelaySpark uses *three musketeers* pattern to define the jobs. This makes your pipeline jobs reusable and portable to CI/CD platforms. In fact, you don't even need a CI/CD platform to run the jobs!
