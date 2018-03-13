﻿using System;
using Microsoft.EntityFrameworkCore;

namespace Ccr.Dnc.Data.EntityFramework.Dnc.Data.EntityFramework.Attributes
{
  public class ConfiguresEntityAttribute
    : Attribute
  {
    private static readonly Type expectedParameterImpl
      = typeof(IEntityTypeConfiguration<>);

    public Type EntityConfigurationType { get; }


    public ConfiguresEntityAttribute(
      Type entityConfigurationType)
    {
      (!expectedParameterImpl.IsInstanceOfType(entityConfigurationType))
        throw new InvalidOperationException(
          $"{entityConfigurationType.Name.SQuote()}");
    }

  }
}
